//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Jan Göbel on 11/06/16.
//  Copyright © 2016 Jan Goebel. All rights reserved.
//

import UIKit
import pop
@IBDesignable
class CustomButton : UIButton {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    @IBInspectable var fontColor: UIColor = UIColor.white {
        didSet {
            setupView()
        }
    }
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.tintColor = fontColor
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDragEnter)
        self.addTarget(self, action: #selector(CustomButton.scaleAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchDragExit)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.95, height: 0.95))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
        
    }
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleDefaultAnimation")
    }
}

