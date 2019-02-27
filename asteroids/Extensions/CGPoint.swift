//
//  CGPoint.swift
//  asteroids
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import UIKit

extension CGPoint {
    func angle(toPoint position: CGPoint) -> CGFloat{
        let dx =  self.x - position.x
        let dy =  self.y - position.y
        
        let radians = atan2(dy, dx) + CGFloat.pi // Angle in radian
        let degree = radians * (180 / CGFloat.pi)  // Angle in degrees
        
        return degree
    }
}
