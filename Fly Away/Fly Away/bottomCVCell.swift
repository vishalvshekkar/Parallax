//
//  bottomCVCell.swift
//  Fly Away
//
//  Created by Vishal on 9/24/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class bottomCVCell: UICollectionViewCell {
    
    @IBOutlet weak var bottomHolder: UIView!
    @IBOutlet weak var bottomImageView: UIImageView!
    static var target : AnyObject?
    
    override func awakeFromNib() {
        bottomHolder.frame = self.contentView.frame
        let button = UIButton(frame: self.contentView.frame)
        button.frame.origin = CGPointZero
        button.setTitle("", forState: UIControlState.Normal)
        button.addTarget(bottomCVCell.target, action: "didDrag:", forControlEvents: UIControlEvents.TouchDown)
        
//        self.contentView.addSubview(button)
    }
    
    
    
    func parallaxEffectOnBackground(view: UIView) {
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
        contentView.addMotionEffect(group)
        
    }
    
}
