//
//  GameOverViewController.swift
//  SpaceShooter
//
//  Created by Michael Blatter on 3/3/19.
//  Copyright © 2019 blatter. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var pointsLabel: UILabel!
    
    private var points = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointsLabel.text = "Points: \(points)"
    }
    
    public func set(points: Int) {
        self.points = points
    }
}
