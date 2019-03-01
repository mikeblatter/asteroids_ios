//
//  Player.swift
//  asteroids
//
//  Created by Michael Blatter on 2/28/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit

struct Player: Sprite {    
    internal let size = CGSize(width: 20, height: 20)
    internal var spriteNode: SKSpriteNode
    internal let texture = SKTexture(imageNamed: "Player")
    
    let shootSound = SKAction.playSoundFileNamed("Shoot.wav", waitForCompletion: false)
    
    public init(position: CGPoint) {
        spriteNode = SKSpriteNode(texture: texture, size: size)
        spriteNode.position = position
    }
    
    public func rotate(to position: CGPoint) {
        let rotateAction = SKAction.rotate(toAngle: direction(to: position), duration: 0.1, shortestUnitArc: true)
        spriteNode.run(rotateAction)
    }
    
    public func createMissile() -> PlayerMissile {
        let missile = PlayerMissile(position: self.spriteNode.position, zRotation: self.spriteNode.zRotation)
        return missile
    }
    
    public func shoot(missile: PlayerMissile, to position: CGPoint) {
        let delta = self.delta(to: position)
        
        let endPositionX = missile.spriteNode.position.x + delta.x * -10 // TODO 100 to deltaX
        let endPositionY = missile.spriteNode.position.y + delta.y * -10 // TODO 100 to deltaY
        let endPosition = CGPoint(x: endPositionX, y: endPositionY)
        
        let missileMoveAction = SKAction.move(to: endPosition, duration: 1)
        
        let actionMoveDone = SKAction.removeFromParent()
        missile.spriteNode.run(SKAction.sequence([missileMoveAction, actionMoveDone]))
        
        spriteNode.run(shootSound)
    }
}
