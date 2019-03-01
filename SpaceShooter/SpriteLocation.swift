//
//  SpriteLocation.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 3/1/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

protocol SpriteLocation {
    var view: SKView? { get }
}

extension SpriteLocation {
    public func randomPointOutsideBounds() -> CGPoint? {
        if let view = self.view {
            let leftEdgeRandom = CGFloat.random(in: view.bounds.minX - 200...view.bounds.minX)
            let topEdgeRandom = CGFloat.random(in: view.bounds.minY - 200...view.bounds.minY)
            let rightEdgeRandom = CGFloat.random(in: view.bounds.maxX...view.bounds.maxX + 200)
            let bottomEdgeRandom = CGFloat.random(in: view.bounds.maxY...view.bounds.maxY + 200)
            
            let newX = (Bool.random()) ? leftEdgeRandom : rightEdgeRandom
            let newY = (Bool.random()) ? topEdgeRandom : bottomEdgeRandom
            
            return CGPoint(x: newX, y: newY)
        }
        
        return nil
    }
    
    
}
