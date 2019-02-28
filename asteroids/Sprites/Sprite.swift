//
//  Sprite.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

let degreesToRadians = CGFloat.pi / 180

protocol Sprite {
    var size: CGSize { get }
    var spriteNode: SKSpriteNode? { get set }
    var texture: SKTexture { get }
}

extension Sprite {
    internal func create() -> SKSpriteNode {
        return SKSpriteNode(texture: texture, size: size)
    }
    
    public func direction(to possibleOtherPosition: CGPoint?) -> CGFloat? {
        if let spritePosition = spriteNode?.position, let otherPosition = possibleOtherPosition {
            let deltaX = spritePosition.x - otherPosition.x
            let deltaY = spritePosition.y - otherPosition.y
            
            let angle = atan2(deltaY, deltaX)
            return angle + 90 * degreesToRadians
        }
        
        return nil
    }
    
    public func add(to scene: SKScene) {
        if let spriteNode = self.spriteNode {
            scene.addChild(spriteNode)
        }
    }
}
