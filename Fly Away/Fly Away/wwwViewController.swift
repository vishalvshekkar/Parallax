//
//  wwwViewController.swift
//  Fly Away
//
//  Created by Vishal on 9/24/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class wwwViewController: UIViewController {

    @IBOutlet weak var rotateView: UIView!
    var stateFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateView.rotate360Degrees(2.0, from: -CGFloat(M_PI * 2.0/8), to: CGFloat(M_PI * 2.0/8), completionDelegate: self)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if stateFlag {
            rotateView.rotate360Degrees(2.0, from: -CGFloat(M_PI * 2.0/8), to: CGFloat(M_PI * 2.0/8), completionDelegate: self)
            stateFlag = false
        }
        else {
            rotateView.rotate360Degrees(2.0, from: CGFloat(M_PI * 2.0/8), to: -CGFloat(M_PI * 2.0/8), completionDelegate: self)
            stateFlag = true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
