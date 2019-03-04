//
//  Sprite.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

let degreesToRadians = CGFloat.pi / 180

enum SpriteType {
    case asteroid
    case background
    case player
    case playerMissile
}

class Sprite: Hashable {
    public let name = UUID().uuidString
    public let spriteNode: SKSpriteNode
    public let spriteType: SpriteType
    
    public var angle: CGFloat = 0
    public var previousAngle: CGFloat = 0
    
    public init(spriteNode: SKSpriteNode, spriteType: SpriteType) {
        self.spriteNode = spriteNode
        self.spriteType = spriteType
        
        // Set unique name to sprite node
        self.spriteNode.name = name
    }
    
    public func delta(to otherPosition: CGPoint) -> CGVector {
        return CGVector(dx: spriteNode.position.x + otherPosition.x, dy: spriteNode.position.y + otherPosition.y)
    }
    
    public func direction(to possibleOtherPosition: CGPoint) -> CGFloat {
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

    // MARK: Hashable + Equatable
    
    public var hashValue: Int {
        return name.hashValue
    }
    
    static func == (lhs: Sprite, rhs: Sprite) -> Bool {
        return lhs.name == rhs.name
    }
}
