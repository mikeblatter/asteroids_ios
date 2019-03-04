//
//  SpriteLocation.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 3/1/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

protocol ScenePhysics {
    var frame: CGRect { get }
    var view: SKView? { get }
    var enlargePhysicsFrameBy: CGFloat { get }
}

extension ScenePhysics {
    var physicsFrame: CGRect {
        return CGRect(x: frame.minX - enlargePhysicsFrameBy,
                      y: frame.minY - enlargePhysicsFrameBy,
                      width: frame.width + enlargePhysicsFrameBy * 2,
                      height: frame.height + enlargePhysicsFrameBy * 2)
    }
    
    public func createPhysicsBody() -> SKPhysicsBody {
        let borderBody = SKPhysicsBody(edgeLoopFrom: physicsFrame)
        
        borderBody.friction = 0
        borderBody.affectedByGravity = false
        
        return borderBody
    }
    
    public func randomPointOutsideScreen() -> CGPoint? {
        if let view = self.view {
            let topFrameEdge = view.frame.maxY
            let leftFrameEdge = view.frame.minX - view.frame.width
            let bottomFrameEdge = -view.frame.height - view.frame.origin.y
            let rightFrameEdge = view.frame.maxX
            
            let edgeOffset = enlargePhysicsFrameBy / 2
            
            let leftEdgeRandom = CGFloat.random(in: leftFrameEdge - edgeOffset...leftFrameEdge)
            let bottomEdgeRandom = CGFloat.random(in: bottomFrameEdge - edgeOffset...bottomFrameEdge)
            let topEdgeRandom = CGFloat.random(in: topFrameEdge...topFrameEdge + edgeOffset)
            let rightEdgeRandom = CGFloat.random(in: rightFrameEdge...rightFrameEdge + edgeOffset)
            
            let newX = (Bool.random()) ? leftEdgeRandom : rightEdgeRandom
            let newY = (Bool.random()) ? topEdgeRandom : bottomEdgeRandom
            
            return CGPoint(x: newX, y: newY)
        }
        
        return nil
    }
}
