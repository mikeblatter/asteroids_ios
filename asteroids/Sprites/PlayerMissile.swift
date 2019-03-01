//
//  PlayerMissile.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct PlayerMissile: Sprite {
    internal let size = CGSize(width: 10, height: 10)
    internal var spriteNode: SKSpriteNode
    internal let texture = SKTexture(imageNamed: "PlayerMissile")
    
    public init(position: CGPoint, zRotation: CGFloat) {
        spriteNode = SKSpriteNode(texture: texture, size: size)
        spriteNode.position = position
        spriteNode.zRotation = zRotation
    }
}
