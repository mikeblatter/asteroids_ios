//
//  PlayerMissile.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct PlayerMissile: Sprite {
    internal var spriteNode: SKSpriteNode
    internal let texture = SKTexture(imageNamed: "PlayerMissile")
    
    public init(position: CGPoint) {
        spriteNode = SKSpriteNode(texture: texture)
        spriteNode.position = position
    }
}
