//
//  File.swift
//  iTunesCoverColor
//
//  Created by Vishal on 9/28/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import CoreImage
import CoreGraphics


extension UIColor{
    
    func isEqualToColor(color: UIColor, withTolerance tolerance: CGFloat = 0.0) -> Bool {
        
        var r1 : CGFloat = 0
        var g1 : CGFloat = 0
        var b1 : CGFloat = 0
        var a1 : CGFloat = 0
        var r2 : CGFloat = 0
        var g2 : CGFloat = 0
        var b2 : CGFloat = 0
        var a2 : CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return fabs(r1 - r2) <= tolerance && fabs(g1 - g2) <= tolerance && fabs(b1 - b2) <= tolerance && fabs(a1 - a2) <= tolerance
    }
    
}

extension UIImage {
    
    func getPixelColor(pixel: CGPoint) -> UIColor {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pixel.y)) + Int(pixel.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    struct ColorDensity {
        var pixelColor = UIColor()
        var pixelCount = Int()
        
        func isEqual(colorDensity: ColorDensity) -> Bool {
            return self.pixelColor.isEqualToColor(colorDensity.pixelColor, withTolerance: 0.1)
        }
    }
    
    func mostRepeatedColors(completion: (RepeatedColors: [UIColor])-> Void)  {
        let image = UIImage(CGImage: self.CGImage!, scale: min(self.size.width, self.size.height)/65.0, orientation: UIImageOrientation.Up)
        let size = image.size
        var arrayOfPixelColors = [ColorDensity]()
        var mostRepeatedPixels = [UIColor]()
        var colorCount = 0
        var secondColorCount = 0
        var thirdColorCount = 0
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        var count = 0
        for var x = 0; x < Int(size.width); x++ {
            for var y = 0; y < Int(size.height); y++ {
                
                let pixelInfo: Int = ((Int(size.width) * Int(y)) + Int(x)) * 4
                let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
                let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
                let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
                let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
                let pixelColor = UIColor(red: r, green: g, blue: b, alpha: a)
                
                if count == 0 {
                    arrayOfPixelColors.append(ColorDensity(pixelColor: pixelColor, pixelCount: 1))
                }
                else {
                    var setFlag = false
                    for indexOfArray in 1..<arrayOfPixelColors.count {
                        if arrayOfPixelColors[indexOfArray].pixelColor.isEqualToColor(pixelColor, withTolerance: 0.1) {
                            arrayOfPixelColors[indexOfArray].pixelCount++
                            setFlag = true
                        }
                    }
                    if !setFlag {
                        arrayOfPixelColors.append(ColorDensity(pixelColor: pixelColor, pixelCount: 1))
                    }
                }
                count++
            }
            
        }
        
        let sortedArray = arrayOfPixelColors.sort({ $0.pixelCount > $1.pixelCount })
        print("Done with the huge task")
        print(arrayOfPixelColors.count)
        for color in arrayOfPixelColors {
            if color.pixelCount > colorCount {
                colorCount = color.pixelCount
            }
            else if color.pixelCount > secondColorCount {
                secondColorCount = color.pixelCount
            }
            else if color.pixelCount > thirdColorCount {
                thirdColorCount = color.pixelCount
            }
        }
        mostRepeatedPixels.append(UIColor())
        mostRepeatedPixels.append(UIColor())
        mostRepeatedPixels.append(UIColor())
        print(thirdColorCount)
        for index in 0..<arrayOfPixelColors.count {
            let color = arrayOfPixelColors[index]
            if color.pixelCount == colorCount {
                mostRepeatedPixels[0] = color.pixelColor
            }
            else if color.pixelCount == secondColorCount {
                mostRepeatedPixels[1] = color.pixelColor
            }
            else if color.pixelCount == thirdColorCount {
                mostRepeatedPixels[2] = color.pixelColor
            }
        }
        
        
        completion(RepeatedColors: mostRepeatedPixels)
    }
    
}
