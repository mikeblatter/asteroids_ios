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

    // Sprites
    private let player = Player(position: CGPoint(x: 0, y: 0))
    
    // Asteroids
    private var asteroids: [Asteroid] = []
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        player.add(to: self)
        
        let physicsFrame = CGRect(x: self.frame.minX - 100, y: self.frame.minY - 100, width: self.frame.width + 200, height: self.frame.height + 200)
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: physicsFrame)
        
        borderBody.friction = 0
        borderBody.affectedByGravity = false
        
        self.physicsBody = borderBody
        physicsBody?.contactTestBitMask = 0x00000001
        physicsWorld.contactDelegate = self
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if let spriteNodeA = contact.bodyA.node, let spriteNodeB = contact.bodyB.node {
            print(spriteNodeA)
            print(spriteNodeB)
        }
        
        
        
        
        print("Collision")
    }
    
    func touchDown(atPoint position:CGPoint) {
        player.rotate(to: position)
        
        let missile = player.createMissile()
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
        while asteroids.count < 5 {
            if let startPoint = randomPointOutsideBounds() {
                let asteroid = Asteroid(position: startPoint)
                asteroid.add(to: self)
                
                asteroids.append(asteroid)
                asteroid.spriteNode.physicsBody?.applyImpulse(CGVector(dx: CGFloat.random(in: -10...10), dy: CGFloat.random(in: -10...10)))
                
                /* let asteroidMoveAction = SKAction.move(to: endPoint, duration: 5)
                
                let removeAsteroidFromList = SKAction.run {
                    if let asteroidIndex = self.asteroids.firstIndex(where: { $0 == asteroid }) {
                        self.asteroids.remove(at: asteroidIndex)
                    }
                }
                
                let actionMoveDone = SKAction.removeFromParent()
                asteroid.spriteNode.run(SKAction.sequence([asteroidMoveAction, actionMoveDone, removeAsteroidFromList]))*/
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