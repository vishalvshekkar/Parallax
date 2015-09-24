//
//  topCVCellCollectionViewCell.swift
//  Fly Away
//
//  Created by Vishal on 9/24/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class topCVCellCollectionViewCell: UICollectionViewCell {
    
    var kVOffset: CGFloat = 0.0
    var kHOffset: CGFloat = 0.0
    
    var kAngleFraction: CGFloat = 100
    var duration : Double = 1.5
    
    @IBOutlet weak var verticallyMovingView: UIView!
    @IBOutlet weak var horizontallyMovingView: UIView!
    @IBOutlet weak var myContentView: UIView!
    
    @IBOutlet weak var verticalConstriant: NSLayoutConstraint!
    @IBOutlet weak var horizontalConstriant: NSLayoutConstraint!
    
    var animationState = 0
    var stateFlag = false
    
    var displayView : UIView? {
        didSet {
            addHolerView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.clearColor()
        initializeHolderView()
        addHolerView()
        parallaxEffectOnBackground()
        self.contentView.rotate360Degrees(duration, from: -CGFloat(M_PI * 2.0)/kAngleFraction, to: CGFloat(M_PI * 2.0)/kAngleFraction, completionDelegate: self)
        startAnimation()
    }
    
    func parallaxEffectOnBackground() {
        let relativeMotionValue = 20
        let verticalMotionEffect : UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -relativeMotionValue
        verticalMotionEffect.maximumRelativeValue = relativeMotionValue
        
        let horizontalMotionEffect : UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -relativeMotionValue
        horizontalMotionEffect.maximumRelativeValue = relativeMotionValue
        
        let group : UIMotionEffectGroup = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        horizontallyMovingView.addMotionEffect(group)
        
    }
    
    func initializeHolderView() {
        horizontallyMovingView.backgroundColor = UIColor.whiteColor()
        horizontallyMovingView.clipsToBounds = true
        
        kVOffset = verticalConstriant.constant/10
        kHOffset = horizontalConstriant.constant/10
        verticalConstriant.constant = 9*kVOffset
        horizontalConstriant.constant = 9*kHOffset
        myContentView.layoutIfNeeded()
        contentView.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI * 2.0))
    }
    
    func addHolerView() {
        if let displayView = displayView {
            let subViews = horizontallyMovingView.subviews
            for subView in subViews {
                subView.removeFromSuperview()
            }
            horizontallyMovingView.addSubview(displayView)
        }
    }
    
    func startAnimation() {
        
        if animationState == 0 {
            self.verticalConstriant.constant = self.verticalConstriant.constant + self.kVOffset*2
            animationState = 1
        }
        else if animationState == 1 {
            self.horizontalConstriant.constant = self.horizontalConstriant.constant + self.kHOffset*2
            animationState = 2
        }
        else if animationState == 2 {
            self.verticalConstriant.constant = self.verticalConstriant.constant - self.kVOffset*2
            animationState = 3
        }
        else if animationState == 3 {
            self.horizontalConstriant.constant = self.horizontalConstriant.constant - self.kHOffset*2
            animationState = 0
        }
        
        UIView.animateWithDuration(1.0, delay: 0, options: [UIViewAnimationOptions.LayoutSubviews, UIViewAnimationOptions.CurveLinear], animations: { () -> Void in
//            print("Animating")
            self.myContentView.layoutIfNeeded()
            }, completion: { (myBoo) -> Void in
//                print("Animation Complete")
                self.startAnimation()
        })
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if stateFlag {
            contentView.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI * 2.0))
            self.contentView.rotate360Degrees(duration, from: -CGFloat(M_PI * 2.0)/kAngleFraction, to: CGFloat(M_PI * 2.0)/kAngleFraction, completionDelegate: self)
            stateFlag = false
        }
        else {
            contentView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2.0))
            self.contentView.rotate360Degrees(duration, from: CGFloat(M_PI * 2.0)/kAngleFraction, to: -CGFloat(M_PI * 2.0)/kAngleFraction, completionDelegate: self)
            stateFlag = true
        }
        
//        print("I'm here")
    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, from: CGFloat = 0.0, to: CGFloat = CGFloat(M_PI * 2.0), completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = from
        rotateAnimation.toValue = to
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}
