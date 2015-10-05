//
//  ViewController.swift
//  iTunesCoverColor
//
//  Created by Vishal on 9/28/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var butt: UIButton!
    
    @IBOutlet weak var tL: UIView!
    @IBOutlet weak var tR: UIView!
    @IBOutlet weak var b: UIView!
    let nameImage = ["City-solution", "landscapes-267a", "video.yahoofinance.com@601650f1-9ced-3e19-b803-b369f11a7e53_FULL","testImage", "bg-header", "blueRing", "red-ring-hi", "images", "images-1", "ghost-570993-1200x799-hq-dsk-wallpapers", "1", "2", "3", "4"]
    var image = String()
    override func viewDidLoad() {
        image = nameImage[13]
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageV = UIImageView(frame: self.view.frame)
        let img = UIImage(named: image)!
        print(img.size)
        imageV.image = img
        imageV.contentMode = UIViewContentMode.ScaleAspectFit
        self.view.addSubview(imageV)
        
    }

    @IBAction func butted(sender: AnyObject) {
        let img = UIImage(named: image)!
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let color = img.mostRepeatedColors { (RepeatedColors) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print(RepeatedColors)
                    self.b.backgroundColor = UIColor(CGColor: RepeatedColors[0].CGColor)
                    self.tR.backgroundColor = UIColor(CGColor: RepeatedColors[1].CGColor)
                    self.tL.backgroundColor = UIColor(CGColor: RepeatedColors[2].CGColor)
                })
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

