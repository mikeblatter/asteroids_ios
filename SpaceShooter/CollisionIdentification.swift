//
//  CollisionIdentification.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 3/3/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import Foundation

enum CollisionType {
    case asteroid
    case background
    case player
    case playerMissile
}

protocol CollisionIdentification {
    var uniqueName: String { get }
    var collisionType: CollisionType { get }
    // var categoryBitMask: UInt32 { get }
}

extension CollisionIdentification {

}
