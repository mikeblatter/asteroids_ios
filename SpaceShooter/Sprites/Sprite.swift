//
//  Sprite.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

let degreesToRadians = CGFloat.pi / 180

protocol Sprite {
    var spriteNode: SKSpriteNode { get }
    var texture: SKTexture { get }
}

extension Sprite {    
    public func delta(to otherPosition: CGPoint) -> CGPoint {
        return CGPoint(x: spriteNode.position.x - otherPosition.x, y: spriteNode.position.y - otherPosition.y)
    }
    
    public func direction(to possibleOtherPosition: CGPoint) -> CGFloat {
        let delta = self.delta(to: possibleOtherPosition)
        let angle = atan2(delta.y, delta.x)
        
        return angle + 90 * degreesToRadians
    }
    
    public func add(to scene: SKScene) {
        scene.addChild(spriteNode)
    }
}
