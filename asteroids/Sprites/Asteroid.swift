//
//  Asteroid.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

class Asteroid: SKSpriteNode {
    private static let asteroidTexture = SKTexture(imageNamed: "Asteroid")
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(size: CGSize) {
        self.init(texture: Asteroid.asteroidTexture, color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
