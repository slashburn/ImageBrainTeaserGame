//
//  Card.swift
//  BrainTeaser
//
//  Created by Jan Göbel on 12/06/16.
//  Copyright © 2016 Jan Goebel. All rights reserved.
//

import UIKit

@IBDesignable
class Card: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }

    let shapes = ["shape1", "shape2", "shape3"]
    var currentShape: String!
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
    }
    override func awakeFromNib() {
        setupView()
        selectShape()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(3))]
        imageView.image = UIImage(named: currentShape)
    }
  
}
