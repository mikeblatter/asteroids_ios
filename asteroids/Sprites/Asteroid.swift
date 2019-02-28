//
//  Asteroid.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

class Asteroid: Sprite {
    internal let size = CGSize(width: 10, height: 10)
    internal var spriteNode: SKSpriteNode?
    internal let texture = SKTexture(imageNamed: "Asteroid")
    
    public init(position: CGPoint) {
        spriteNode = create()
        spriteNode?.position = position
    }
}
