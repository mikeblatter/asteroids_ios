//
//  PlayerMissile.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

class PlayerMissile: Sprite {
    public static let categoryBitMask = UInt32(2)

    internal let texture = SKTexture(imageNamed: "PlayerMissile")
    
    public init(position: CGPoint) {
        super.init(spriteNode: SKSpriteNode(texture: texture), spriteType: SpriteType.playerMissile)
        
        spriteNode.position = position
        spriteNode.name = name
        
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: max(spriteNode.size.width / 2,spriteNode.size.height / 2))
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.allowsRotation = false
        
        spriteNode.physicsBody?.categoryBitMask = PlayerMissile.categoryBitMask
        spriteNode.physicsBody?.contactTestBitMask = Asteroid.categoryBitMask | GameScene.categoryBitMask
        spriteNode.physicsBody?.collisionBitMask = Asteroid.categoryBitMask | GameScene.categoryBitMask
    }
}
