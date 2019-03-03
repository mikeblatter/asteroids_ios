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
    var physicsFrame: CGRect? { get }
}

extension SpriteLocation {
    public func randomPointOutsideScreen() -> CGPoint? {
        if let physicsFrame = self.physicsFrame, let view = self.view {
            let leftEdgeRandom = CGFloat.random(in: physicsFrame.minX...view.bounds.minX)
            let topEdgeRandom = CGFloat.random(in: physicsFrame.minY...view.bounds.minY)
            let rightEdgeRandom = CGFloat.random(in: view.bounds.maxX...physicsFrame.maxX)
            let bottomEdgeRandom = CGFloat.random(in: view.bounds.maxY...physicsFrame.maxY)
            
            let newX = (Bool.random()) ? leftEdgeRandom : rightEdgeRandom
            let newY = (Bool.random()) ? topEdgeRandom : bottomEdgeRandom
            
            return CGPoint(x: newX, y: newY)
        }
        
        return nil
    }
}
