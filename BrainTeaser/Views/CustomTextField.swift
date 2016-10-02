//
//  CustomTextField.swift
//  BrainTeaser
//
//  Created by Jan Göbel on 11/06/16.
//  Copyright © 2016 Jan Goebel. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    @IBInspectable var inset : CGFloat = 0.0
    @IBInspectable var cornerRadius : CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
