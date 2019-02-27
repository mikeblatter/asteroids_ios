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
    let playerSprite = SKSpriteNode(imageNamed: "Player")
    let cannonSprite = SKSpriteNode(imageNamed: "Cannon")
    let turretSprite = SKSpriteNode(imageNamed: "Turret")
    
    public var deadCenter: CGPoint? = nil
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var player: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        size = view.bounds.size
        deadCenter = CGPoint(x: size.width/2, y: size.height/2)
    }

    override func sceneDidLoad() {
        if let deadCenter = self.deadCenter {
            playerSprite.position = deadCenter
            addChild(playerSprite)
        }
        
        self.lastUpdateTime = 0
    }
    
    func touchDown(atPoint position:CGPoint) {
        if let deadCenter = self.deadCenter {
            //let playerRotateAction = SKAction.rotate(byAngle: angleFromCenter, duration: 1)
            //self.player?.run(playerRotateAction)
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
