//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SpriteLocation, SKPhysicsContactDelegate {
    private var lastUpdateTime : TimeInterval = 0

    var physicsFrame: CGRect? = nil
    
    // Player
    
    private let player = Player(position: CGPoint(x: 0, y: 0))
    private var playerMissiles: [String: PlayerMissile] = [:]
    
    // Asteroids
    private var asteroids: [String: Asteroid] = [:]

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    override func sceneDidLoad() {
        lastUpdateTime = 0
        
        scene?.name = UUID().uuidString
    }
    
    override func didMove(to view: SKView) {
        player.add(to: self)
        
        physicsFrame = CGRect(x: self.frame.minX - 100, y: self.frame.minY - 100, width: self.frame.width + 200, height: self.frame.height + 200)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: physicsFrame!)
        
        borderBody.friction = 0
        borderBody.affectedByGravity = false
        
        self.physicsBody = borderBody
        physicsBody?.contactTestBitMask = 0x00000001
        physicsWorld.contactDelegate = self
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if let scene = self.scene, let spriteNodeA = contact.bodyA.node, let spriteNodeB = contact.bodyB.node {
            if let nameA = spriteNodeA.name, let nameB = spriteNodeB.name {
                let asteroidA = asteroids.keys.contains(nameA) ? true : false
                let asteroidB = asteroids.keys.contains(nameB) ? true : false
                
                let playerA = (player.name == nameA) ? true : false
                let playerB = (player.name == nameB) ? true : false
                
                let playerMissileA = playerMissiles.keys.contains(nameA) ? true : false
                let playerMissileB = playerMissiles.keys.contains(nameB) ? true : false
                
                let gameSceneA = (scene.name == nameA) ? true : false
                let gameSceneB = (scene.name == nameB) ? true : false
            
                if (playerMissileA || playerMissileB) && (gameSceneA || gameSceneB) {
                    // Player missile hit edge of screen, remove
                    let playerMissileName = (playerMissileA) ? nameA : nameB
                    playerMissiles[playerMissileName]?.spriteNode.removeFromParent()
                    playerMissiles[playerMissileName] = nil
                }
                
                if (asteroidA || asteroidB) && (gameSceneA || gameSceneB) {
                    // Asteroid hit edge of screen, remove
                    let asteroidName = (asteroidA) ? nameA : nameB
                    asteroids[asteroidName]?.spriteNode.removeFromParent()
                    asteroids[asteroidName] = nil
                }
                
                if (asteroidA || asteroidB) && (playerA || playerB) {
                    // Asteroid hit player, loses life
                    let asteroidName = (asteroidA) ? nameA : nameB
                    asteroids[asteroidName]?.spriteNode.removeFromParent()
                    asteroids[asteroidName] = nil
                    
                    //player.spriteNode.removeFromParent()
                }
                
                if (asteroidA || asteroidB) && (playerMissileA || playerMissileB) {
                    // Player Missile hit Asteroid, destory both
                    let playerMissileName = (playerMissileA) ? nameA : nameB
                    playerMissiles[playerMissileName]?.spriteNode.removeFromParent()
                    playerMissiles[playerMissileName] = nil
                    
                    let asteroidName = (asteroidA) ? nameA : nameB
                    asteroids[asteroidName]?.spriteNode.removeFromParent()
                    asteroids[asteroidName] = nil
                }
            }
        }
    }
    
    func touchDown(atPoint position:CGPoint) {
        player.rotate(to: position)
        
        let missile = player.createMissile()
        playerMissiles[missile.name] = missile
        
        missile.add(to: self)
        
        // Shoot Missile
        player.shoot(missile: missile, to: position)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        while asteroids.count < 10 {
            if let startPoint = randomPointOutsideScreen() {
                let asteroid = Asteroid(position: startPoint)
                asteroid.add(to: self)
                
                asteroids[asteroid.name] = asteroid
                asteroid.spriteNode.physicsBody?.applyImpulse(CGVector(dx: CGFloat.random(in: -20...20), dy: CGFloat.random(in: -20...20)))
            }
        }

        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
