//
//  ScoreVC.swift
//  BrainTeaser
//
//  Created by Jan Göbel on 13/06/16.
//  Copyright © 2016 Jan Goebel. All rights reserved.
//

import UIKit

class ScoreVC: UIViewController {
   
    @IBOutlet weak var scoreLabel: UILabel!
    var correctCards: Int!
    var wrongCards: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(correctCards) / \(correctCards + wrongCards)"
    }
}
