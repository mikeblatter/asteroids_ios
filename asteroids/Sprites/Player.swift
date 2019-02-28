//
//  Player.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct Player: Sprite {    
    internal let size = CGSize(width: 20, height: 20)
    internal var spriteNode: SKSpriteNode?
    internal let texture = SKTexture(imageNamed: "Player")
    
    public init(position: CGPoint) {
        spriteNode = create()
        spriteNode?.position = position
    }
    
    public func rotate(to position: CGPoint) {
        let possibleRotateDirection = direction(to: position)
        if let rotateDirection = possibleRotateDirection {
            let rotateAction = SKAction.rotate(toAngle: rotateDirection, duration: 0.1, shortestUnitArc: true)
            spriteNode?.run(rotateAction)
        }
    }
}
