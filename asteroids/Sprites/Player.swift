//
//  Player.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

class Player: Sprite {    
    internal let size = CGSize(width: 20, height: 20)
    internal var spriteNode: SKSpriteNode?
    internal let texture = SKTexture(imageNamed: "Player")
    
    public init(position: CGPoint) {
        spriteNode = create()
        spriteNode?.position = position
    }
}
