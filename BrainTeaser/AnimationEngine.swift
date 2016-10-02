//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Jan Göbel on 11/06/16.
//  Copyright © 2016 Jan Goebel. All rights reserved.
//

import UIKit
import pop


class AnimationEngine {
    class var offScreenRightPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    class var offScreenLeftPosition: CGPoint {
        return CGPoint(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    class var screenCenterPosition: CGPoint {
        
        /*
            TODO: swap the values if we are in Landscape mode
         */
        return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    }


    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
            
        }
        self.constraints = constraints
    }
    
    func animateOnScreen(_ delay: Int) {
        let time = DispatchTime.now() + Double(Int64(Double(delay) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time){
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim?.toValue = self.originalConstants[index]
                moveAnim?.springBounciness = 12
                moveAnim?.springSpeed = 12
                
                if index > 0 {
                    moveAnim?.dynamicsFriction += 10 + CGFloat(index)
                }
                
                let con = self.constraints[index]
                con.pop_add(moveAnim, forKey: "moveOnScreen")
                index = index + 1
                
            } while (index < self.constraints.count)
        }
    }
    class func animateToPosition(_ view: UIView, position: CGPoint, completion: @escaping (POPAnimation?, Bool) -> Void) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim?.toValue = NSValue(cgPoint: position)
        moveAnim?.springBounciness = 8
        moveAnim?.springSpeed = 8
        moveAnim?.completionBlock = completion
        view.pop_add(moveAnim, forKey: "moveToPosition")
    }
    class func popAnimation(_ view: UIView) {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 25

        view.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
}
