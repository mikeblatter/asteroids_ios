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
    public func delta(to otherPosition: CGPoint) -> CGVector {
        return CGVector(dx: spriteNode.position.x - otherPosition.x, dy: spriteNode.position.y - otherPosition.y)
    }
    
    public func direction(to possibleOtherPosition: CGPoint) -> CGFloat {
        let delta = self.delta(to: possibleOtherPosition)
        let angle = atan2(delta.dy, delta.dx)
        
        return angle + 90 * degreesToRadians
    }
    
    public func add(to scene: SKScene) {
        scene.addChild(spriteNode)
    }
}
