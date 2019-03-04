//
//  Player.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

class Player: Sprite {
    public static let categoryBitMask = UInt32(4)

    internal let texture = SKTexture(imageNamed: "Player")
    
    internal let shootSound = SKAction.playSoundFileNamed("Shoot.wav", waitForCompletion: false)
    
    public init(position: CGPoint) {
        super.init(spriteNode: SKSpriteNode(texture: texture), spriteType: SpriteType.player)
        
        spriteNode.position = position

        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: max(spriteNode.size.width / 2,spriteNode.size.height / 2))
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.isDynamic = false
        spriteNode.physicsBody?.pinned = true
        
        spriteNode.physicsBody?.categoryBitMask = Player.categoryBitMask
        spriteNode.physicsBody?.contactTestBitMask = Asteroid.categoryBitMask
        spriteNode.physicsBody?.collisionBitMask = Asteroid.categoryBitMask
    }
    
    public func rotate(to position: CGPoint) {
        let rotateAction = SKAction.rotate(toAngle: direction(to: position), duration: 0.1, shortestUnitArc: true)
        spriteNode.run(rotateAction)
    }
    
    public func createMissile() -> PlayerMissile {
        let newPosition = CGPoint(x: spriteNode.position.x, y: spriteNode.position.y)
        let missile = PlayerMissile(position: newPosition)
        return missile
    }
    
    public func shoot(missile: PlayerMissile, to position: CGPoint) {
        let direction = self.direction(to: position)
        missile.spriteNode.zRotation = direction
        
        let delta = self.delta(to: position)
        let force = CGVector(dx: delta.dx, dy: delta.dy)

        missile.spriteNode.physicsBody?.applyForce(force)
        spriteNode.run(shootSound)
    }
}
