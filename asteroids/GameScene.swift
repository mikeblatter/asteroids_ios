//
//  GameScene.swift
//  asteroids
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit
import GameplayKit

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

class GameScene: SKScene {
    private var lastUpdateTime : TimeInterval = 0
    
    // Node Textures (images to set to nodes)
    private let asteroidTexture = SKTexture(imageNamed: "Asteroid")
    private let playerTexture = SKTexture(imageNamed: "Player")
    private let playerMissleTexture = SKTexture(imageNamed: "PlayerMissle")
    
    // Sprites
    private var player: SKSpriteNode? = nil
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    // Constants
    let playerMissileSpeed: CGFloat = 300.0
    
    override func sceneDidLoad() {
        // Get player and set image
        player = self.childNode(withName: "//Player") as? SKSpriteNode
        player!.texture = self.playerTexture

        self.lastUpdateTime = 0
        
        scene?.addChild(getAsteroid())
    }
    
    func getAsteroid() -> SKSpriteNode {
        let asteroid = SKSpriteNode(texture: asteroidTexture, size: CGSize(width: 20.0, height: 20.0))
        asteroid.position = CGPoint(x: 100, y: 100)
        
        return asteroid
    }
    
    func touchDown(atPoint position:CGPoint) {
        if let player = self.player {
            
            let deltaX = player.position.x - position.x
            let deltaY = player.position.y - position.y
            
            let angle = atan2(deltaY, deltaX)
            let rotation = angle + 90 * degreesToRadians
            
            let playerRotateAction = SKAction.rotate(toAngle: rotation, duration: 0.1, shortestUnitArc: true)
            self.player?.run(playerRotateAction)
            
            // Shoot
            let missile = SKSpriteNode(imageNamed: "PlayerMissile")
            missile.position = player.position
            missile.zRotation = rotation
            
            addChild(missile)
            
            let endPositionX = missile.position.x + deltaX * -10
            let endPositionY = missile.position.y + deltaY * -10
            let endPosition = CGPoint(x: endPositionX, y: endPositionY)
            
            let missileMoveAction = SKAction.move(to: endPosition, duration: 1)
            
            let actionMoveDone = SKAction.removeFromParent()
            missile.run(SKAction.sequence([missileMoveAction, actionMoveDone]))
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
