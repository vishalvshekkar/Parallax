//
//  ViewController.swift
//  Blur
//
//  Created by Vishal on 9/28/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pinky: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pinky.blur(blurRadius: 2.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

