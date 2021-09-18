//
//  FallingAnimation.swift
//  MyAnimations
//
//  Created by Maria Ugorets on 18.09.2021.
//  Copyright © 2021 MariaUgorets. All rights reserved.
//
import UIKit

enum FallingAnimationType {
    case leaf, feather
}

class FallingAnimationViewController: UIViewController {
    var type: FallingAnimationType = .leaf
    var animatedView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch type {
        case .leaf:
            view.backgroundColor = #colorLiteral(red: 0.8001092076, green: 0.8629137874, blue: 0.6916273832, alpha: 1)
            let leafImageView = UIImageView(image: #imageLiteral(resourceName: "leaf"))
            leafImageView.frame = CGRect(x: view.center.x, y: 100, width: 80, height: 80)
            view.addSubview(leafImageView)
            animatedView = leafImageView
        case .feather:
            view.backgroundColor = #colorLiteral(red: 0.9572492242, green: 0.9488092065, blue: 0.5508366227, alpha: 1)
            let featherImageView = UIImageView(image: #imageLiteral(resourceName: "feather"))
            featherImageView.frame = CGRect(x: view.center.x, y: 100, width: 100, height: 100)
            featherImageView.layer.compositingFilter = "darkenBlendMode"
            view.addSubview(featherImageView)
            animatedView = featherImageView
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch type {
        case .feather:
            applyFallingLeafAnimation(in: view.bounds, duration: 8)
        case .leaf:
            applyFallingLeafAnimation(in: view.bounds, duration: 5)

        }
    }
    
    func applyFallingLeafAnimation(in frame: CGRect, duration: TimeInterval) {
        guard let animatedView = self.animatedView else {
            return
        }
        let start = animatedView.center
        
        let verticalStep = (frame.height - start.y) / 6
        var verticalPosition = start.y + verticalStep
        var horizontalStep = animatedView.frame.width

        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModeCubic, .repeat], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.25) {
                animatedView.center = CGPoint(x: start.x - horizontalStep, y: verticalPosition)
                animatedView.transform = CGAffineTransform(rotationAngle: -45)
            }
            
            verticalPosition += verticalStep
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.25) {
                animatedView.center = CGPoint(x: start.x + horizontalStep, y: verticalPosition)
                animatedView.transform = CGAffineTransform(rotationAngle: 180)
            }
            
            verticalPosition += (verticalStep * 1.5)
            horizontalStep += (horizontalStep * 1.5)
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                animatedView.center = CGPoint(x: start.x - horizontalStep, y: verticalPosition)
                animatedView.transform = CGAffineTransform(rotationAngle: -45)
            }
            
            verticalPosition += (verticalStep * 1.8)
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                animatedView.center = CGPoint(x: start.x + horizontalStep, y: verticalPosition)
                animatedView.transform = CGAffineTransform(rotationAngle: 180)
            }
        })
    }
}
