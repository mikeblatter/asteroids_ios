//
//  Asteroid.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

class Asteroid: Sprite {
    public static let categoryBitMask = UInt32(1)
    
    internal let size = CGSize(width: 100, height: 100)
    internal let texture = SKTexture(imageNamed: "Asteroid")

    public init(position: CGPoint) {
        super.init(spriteNode: SKSpriteNode(texture: texture, size: size), collisionType: CollisionType.asteroid)
        
        spriteNode.position = position
        
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: max(size.width / 2, size.height / 2))
        spriteNode.physicsBody?.affectedByGravity = false
        
        spriteNode.physicsBody?.categoryBitMask = Asteroid.categoryBitMask
        spriteNode.physicsBody?.contactTestBitMask = PlayerMissile.categoryBitMask | GameScene.categoryBitMask | Asteroid.categoryBitMask
        spriteNode.physicsBody?.mass = 100
    }
}
