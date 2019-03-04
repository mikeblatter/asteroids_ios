//
//  GameViewController.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 2/27/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameInformationDelegate {
    func update(lives: Int)
    func update(points: Int)
    
    func gameOver(points: Int)
}

class GameViewController: UIViewController, GameInformationDelegate {
    @IBOutlet weak var sceneView: SKView!
    
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBAction func exitAction(_ sender: Any) {
        performSegue(withIdentifier: "GameGameOverSegue", sender: self)
    }
    
    private var points: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                // Copy gameplay related content over to the scene
                sceneNode.gameInformationDelegate = self
                
                // TODO: see if need to add anything here, maybe on orientation change?
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.sceneView {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameGameOverSegue" {
            if let controller = segue.destination as? GameOverViewController {
                controller.set(points: points)
            }
        }
    }
    
    func update(lives: Int) {
        livesLabel.text = "Lives: \(lives)"
    }
    
    func update(points: Int) {
        self.points = points
        pointsLabel.text = "Points: \(points)"
    }
    
    func gameOver(points: Int) {
        performSegue(withIdentifier: "GameGameOverSegue", sender: self)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
