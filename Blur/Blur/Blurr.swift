//
//  File.swift
//  Blur
//
//  Created by Vishal on 9/28/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

extension UIView: Blurable {
    
    var isBlurred: Bool {
        let subViews = self.subviews
        for subView in subviews {
            if subView is BlurOverlay {
                return true
            }
        }
        return false
    }
    
    func blur(blurRadius blurRadius: Float) {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let viewImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageToBlur: CIImage = CIImage(CGImage: viewImage.CGImage!)
        let gaussianBlurFilter: CIFilter = CIFilter(name: "CIGaussianBlur")!
        gaussianBlurFilter.setValue(imageToBlur, forKey: "inputImage")
        gaussianBlurFilter.setValue(NSNumber(float: blurRadius), forKey: "inputRadius")
        let resultImage: CIImage = gaussianBlurFilter.valueForKey("outputImage") as! CIImage
        let endImage: UIImage = UIImage(CIImage: resultImage)
        let newView = BlurOverlay(frame: self.bounds)
        newView.image = endImage
        self.addSubview(newView)
    }
    
    func unBlur() {
        let subViews = self.subviews
        for subView in subviews {
            if subView is BlurOverlay {
                subView.removeFromSuperview()
            }
        }
    }
}

protocol Blurable {
    var isBlurred: Bool { get }
    func blur(blurRadius blurRadius: Float)
    func unBlur()
}

class BlurOverlay: UIImageView {
    
}