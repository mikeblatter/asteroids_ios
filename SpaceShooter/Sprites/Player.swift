//
//  Player.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct Player: Sprite {
    public let name = UUID().uuidString
    
    internal var spriteNode: SKSpriteNode
    internal let texture = SKTexture(imageNamed: "Player")
    
    let shootSound = SKAction.playSoundFileNamed("Shoot.wav", waitForCompletion: false)
    
    public init(position: CGPoint) {
        spriteNode = SKSpriteNode(texture: texture)
        spriteNode.name = name
        spriteNode.position = position
        
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: max(spriteNode.size.width / 2,spriteNode.size.height / 2))
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.contactTestBitMask = 0x00000001
        spriteNode.physicsBody?.isDynamic = false
        spriteNode.physicsBody?.pinned = true
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
        let force = CGVector(dx: -delta.dx * 1.5, dy: -delta.dy * 1.5)
        missile.spriteNode.physicsBody?.applyForce(force)

        spriteNode.run(shootSound)
    }
}
