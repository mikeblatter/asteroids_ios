//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SpriteLocation, SKPhysicsContactDelegate, CollisionIdentification {
    
    private var lastUpdateTime : TimeInterval = 0
    internal var physicsFrame: CGRect? = nil
    
    // CollisionIdentification
    public let uniqueName = UUID().uuidString
    public let collisionType = CollisionType.background
    public static let categoryBitMask = UInt32(8)
    
    // Sprites
    
    private var asteroids: [String: Asteroid] = [:]
    private var player = Player(position: CGPoint(x: 0, y: 0))
    private var playerMissiles: [String: PlayerMissile] = [:]

    override func sceneDidLoad() {
        lastUpdateTime = 0
        
        scene?.name = uniqueName
    }
    
    override func didMove(to view: SKView) {
        player.add(to: self)
        
        physicsFrame = CGRect(x: self.frame.minX - 100, y: self.frame.minY - 100, width: self.frame.width + 200, height: self.frame.height + 200)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: physicsFrame!)
        
        borderBody.friction = 0
        borderBody.affectedByGravity = false
        
        self.physicsBody = borderBody
        
        physicsBody?.categoryBitMask = GameScene.categoryBitMask
        physicsBody?.contactTestBitMask = PlayerMissile.categoryBitMask | Asteroid.categoryBitMask
        
        physicsWorld.contactDelegate = self
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if let scene = self.scene, let spriteNodeA = contact.bodyA.node, let spriteNodeB = contact.bodyB.node {
            let nodes = [spriteNodeA, spriteNodeB]
            var bodies: [CollisionIdentification] = []
            
            for node in nodes {
                if let name = node.name {
                    if let asteroid = asteroids[name] {
                       bodies.append(asteroid)
                    }
                    else if let playerMissile = playerMissiles[name] {
                       bodies.append(playerMissile)
                    }
                    else if player.uniqueName == name {
                       bodies.append(player)
                    }
                    else if scene.name == name {
                       bodies.append(self)
                    }
                }
            }
            
            collision(between: bodies)
        }
    }

    func collision(between sprites: Array<CollisionIdentification>) {
        let spriteTypes: Set<CollisionType> = Set(sprites.map { $0.collisionType })
        
        switch spriteTypes {
        case [.asteroid, .asteroid]:
            for sprite in sprites {
                scene?.childNode(withName: sprite.uniqueName)?.removeFromParent()
                asteroids[sprite.uniqueName] = nil
            }
        case [.asteroid, .player]:
            for sprite in sprites where sprite.collisionType == .asteroid {
                scene?.childNode(withName: sprite.uniqueName)?.removeFromParent()
                asteroids[sprite.uniqueName] = nil
            }
        case [.playerMissile, .asteroid]:
            for sprite in sprites where sprite.collisionType == .asteroid {
                scene?.childNode(withName: sprite.uniqueName)?.removeFromParent()
                asteroids[sprite.uniqueName] = nil
            }
            
            for sprite in sprites where sprite.collisionType == .playerMissile {
                scene?.childNode(withName: sprite.uniqueName)?.removeFromParent()
                playerMissiles[sprite.uniqueName] = nil
            }
        case [.playerMissile, .background]:
            for sprite in sprites where sprite.collisionType == .playerMissile {
                scene?.childNode(withName: sprite.uniqueName)?.removeFromParent()
                playerMissiles[sprite.uniqueName] = nil
            }
        case [.asteroid, .background]:
            for sprite in sprites where sprite.collisionType == .asteroid {
                scene?.childNode(withName: sprite.uniqueName)?.removeFromParent()
                asteroids[sprite.uniqueName] = nil
            }
        default:
            break
        }
    }
    
    func touchDown(atPoint position:CGPoint) {
        player.rotate(to: position)
        
        let missile = player.createMissile()
        playerMissiles[missile.uniqueName] = missile
        
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
            if let startPoint = randomPointOutsideScreen(), let endPoint = randomPointOutsideScreen() {
                let asteroid = Asteroid(position: startPoint)
                asteroid.add(to: self)
                
                asteroids[asteroid.uniqueName] = asteroid
                let vector = asteroid.delta(to: endPoint)
                asteroid.spriteNode.physicsBody?.applyForce(CGVector(dx: vector.dx * 10, dy: vector.dy * 10), at: endPoint)
            }
        }

        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }

        // Calculate time since last update
        //let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
    }
}
