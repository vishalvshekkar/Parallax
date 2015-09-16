//
//  ParallaxCollectionViewCell.swift
//  ParallaxEffects
//
//  Created by Vishal on 9/16/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

let ImageHeight: CGFloat = 200.0
let OffsetSpeed: CGFloat = 25.0

class ParallaxCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    func offset(offset: CGPoint) {
        imageView.frame = CGRectOffset(self.imageView.bounds, offset.x, offset.y)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parallaxEffectOnBackground()
    }
    
    func parallaxEffectOnBackground() {
        let relativeMotionValue = 50
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
        
        self.imageView.addMotionEffect(group)
    }
}
