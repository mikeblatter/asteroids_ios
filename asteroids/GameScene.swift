//
//  GameScene.swift
//  asteroids
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var lastUpdateTime : TimeInterval = 0
    
    // Node Textures (images to set to nodes)
    private let playerMissleTexture = SKTexture(imageNamed: "PlayerMissle")
    
    // Sprites
    private let player = Player(position: CGPoint(x: 0, y: 0))
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    // Constants
    let playerMissileSpeed: CGFloat = 300.0
    
    // Sounds
    let shootSound = SKAction.playSoundFileNamed("Shoot.wav", waitForCompletion: false)
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        player.add(to: self)
        
        let asteroid = Asteroid(position: CGPoint(x: 0, y: 100))
        asteroid.add(to: self)
    }
    
    func touchDown(atPoint position:CGPoint) {
        player.rotate(to: position)
        
        if let playerSpriteNode = player.spriteNode, let direction = player.direction(to: position) {
            let missile = SKSpriteNode(imageNamed: "PlayerMissile")
            missile.position = playerSpriteNode.position
            missile.zRotation = direction
            
            addChild(missile)
            
            let endPositionX = missile.position.x + 100 * -10 // TODO 100 to deltaX
            let endPositionY = missile.position.y + 100 * -10 // TODO 100 to deltaY
            let endPosition = CGPoint(x: endPositionX, y: endPositionY)
            
            let missileMoveAction = SKAction.move(to: endPosition, duration: 1)
            
            let actionMoveDone = SKAction.removeFromParent()
            missile.run(SKAction.sequence([missileMoveAction, actionMoveDone]))
            
            run(shootSound)
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
