//
//  Asteroid.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct Asteroid: Equatable, Sprite {
    public let name = UUID().uuidString
    
    internal let size = CGSize(width: 100, height: 100)
    internal let spriteNode: SKSpriteNode
    internal let texture = SKTexture(imageNamed: "Asteroid")
    
    public init(position: CGPoint) {
        spriteNode = SKSpriteNode(texture: texture, size: size)
        spriteNode.position = position
        spriteNode.name = name
        
        spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: max(size.width / 2, size.height / 2))
        spriteNode.physicsBody?.affectedByGravity = false
        spriteNode.physicsBody?.contactTestBitMask = 0x00000001
    }
}
