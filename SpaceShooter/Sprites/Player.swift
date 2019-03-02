//
//  Player.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct Player: Sprite {    
    internal var spriteNode: SKSpriteNode
    internal let texture = SKTexture(imageNamed: "Player")
    
    let shootSound = SKAction.playSoundFileNamed("Shoot.wav", waitForCompletion: false)
    
    public init(position: CGPoint) {
        spriteNode = SKSpriteNode(texture: texture)
        spriteNode.position = position
        
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: max(spriteNode.size.width / 2,spriteNode.size.height / 2))
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.isDynamic = false
        spriteNode.physicsBody?.pinned = true
        spriteNode.physicsBody?.contactTestBitMask = 0x00000001
    }
    
    public func rotate(to position: CGPoint) {
        let rotateAction = SKAction.rotate(toAngle: direction(to: position), duration: 0.1, shortestUnitArc: true)
        spriteNode.run(rotateAction)
    }
    
    public func createMissile() -> PlayerMissile {
        let missile = PlayerMissile(position: self.spriteNode.position)
        return missile
    }
    
    public func shoot(missile: PlayerMissile, to position: CGPoint) {
        missile.spriteNode.zRotation = self.direction(to: position)

        let delta = self.delta(to: position)
        let force = CGVector(dx: -delta.dx * 10, dy: -delta.dy * 10)
        missile.spriteNode.physicsBody?.applyForce(force)
        
        
        
        
            //.applyForce(force, atPosition: position, impulse: true)
        //missile.spriteNode.physicsBody?.applyTorque(100)
        //missile.spriteNode.physicsBody?.velocity = 10
        //missile.spriteNode.physicsBody?.applyImpulse(CGVector(dx: 10 * cos(position),
                                                   //dy: 10 * sin(position)))
        
        
        
        
        
        
        //missile.spriteNode.physicsBody?.angularVelocity = 0
        //missile.spriteNode.physicsBody?.applyAngularImpulse(self.direction(to: position))
        
        //let endPositionX = missile.spriteNode.position.x + delta.x * -10
        //let endPositionY = missile.spriteNode.position.y + delta.y * -10
        //let endPosition = CGPoint(x: endPositionX, y: endPositionY)
        
        //let missileMoveAction = SKAction.move(to: endPosition, duration: 1)
        
        //let actionMoveDone = SKAction.removeFromParent()
        //missile.spriteNode.run(SKAction.sequence([missileMoveAction, actionMoveDone]))
        
        spriteNode.run(shootSound)
    }
}
