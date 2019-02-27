//
//  GameScene.swift
//  asteroids
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit
import GameplayKit

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

class GameScene: SKScene {
    let playerSprite = SKSpriteNode(imageNamed: "Player")
    let cannonSprite = SKSpriteNode(imageNamed: "Cannon")
    let turretSprite = SKSpriteNode(imageNamed: "Turret")
    
    var accelerometerX: UIAccelerationValue = 0
    var accelerometerY: UIAccelerationValue = 0
    var playerAcceleration = CGVector(dx: 0, dy: 0)
    var playerVelocity = CGVector(dx: 0, dy: 0)
    var lastUpdateTime: CFTimeInterval = 0
    var playerAngle: CGFloat = 0
    var previousAngle: CGFloat = 0
    let playerHealthBar = SKSpriteNode()
    let cannonHealthBar = SKSpriteNode()
    var playerHP = maxHealth
    var cannonHP = maxHealth
    var playerSpin: CGFloat = 0
    
    public var deadCenter: CGPoint? = nil
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var player: SKSpriteNode?

    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.player = self.childNode(withName: "//player") as? SKSpriteNode
        
        if let player = self.player {
            player.alpha = 0.0
            player.run(SKAction.fadeIn(withDuration: 2.0))
            player.zRotation = CGFloat(0)
        }
    }
    
    func touchDown(atPoint position:CGPoint) {
        if let deadCenter = self.deadCenter {
            let angle = atan2(playerVelocity.dy, playerVelocity.dx)
            
            
            
            let angleFromCenter = position.angle(toPoint: deadCenter)
            let currentRotation = self.player?.zRotation
            
            let v1 = CGVector(dx: p1.x - deadCenter.x, dy: p1.y - deadCenter.y)
            let v2 = CGVector(dx: p2.x - deadCenter.x, dy: p2.y - deadCenter.y)
            let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
            var deg = angle * CGFloat(180.0 / M_PI)
            if deg < 0 { deg += 360.0 }
            
            print(deg)

            let playerRotateAction = SKAction.rotate(byAngle: angleFromCenter, duration: 1)
            self.player?.run(playerRotateAction)
        }
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
