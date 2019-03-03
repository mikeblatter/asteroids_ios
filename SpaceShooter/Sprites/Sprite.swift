//
//  Sprite.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

let degreesToRadians = CGFloat.pi / 180

enum SpriteBitMask {
    case asteroid
    case gameScene
    case player
    case playerMissile
}

protocol Sprite {
    var angle: CGFloat { get set }
    var previousAngle: CGFloat { get set }
    
    var name: String { get }
    
    var spriteNode: SKSpriteNode { get }
    var texture: SKTexture { get }
}

extension Sprite {    
    public func delta(to otherPosition: CGPoint) -> CGVector {
        return CGVector(dx: spriteNode.position.x + otherPosition.x, dy: spriteNode.position.y + otherPosition.y)
    }
    
    public mutating func direction(to possibleOtherPosition: CGPoint) -> CGFloat {
        let rotationBlendFactor: CGFloat = 0.2
        
        let delta = self.delta(to: possibleOtherPosition)

        angle = atan2(delta.dy, delta.dx)
        
        // did angle flip from +π to -π, or -π to +π?
        if angle - previousAngle > CGFloat.pi {
            angle += 2 * CGFloat.pi
        } else if previousAngle - angle > CGFloat.pi {
            angle -= 2 * CGFloat.pi
        }
        
        previousAngle = angle
        angle = angle * rotationBlendFactor + angle * (1 - rotationBlendFactor)
        
        // convert to radians
        return angle - 90 * degreesToRadians
    }
    
    public func add(to scene: SKScene) {
        scene.addChild(spriteNode)
    }
}
