//
//  ViewController.swift
//  ParallaxEffects
//
//  Created by Vishal on 9/16/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit
let parallaxCellIdentifier = "parallaxCell"

class ViewController: UICollectionViewController {

    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...14 {
            images.append("\(i)")
        }
        for i in 0...14 {
            images.append("\(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let parallaxCell = collectionView.dequeueReusableCellWithReuseIdentifier(parallaxCellIdentifier, forIndexPath: indexPath) as! ParallaxCollectionViewCell
        parallaxCell.image = UIImage(named: images[indexPath.row])!
        return parallaxCell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView!) {
        if let visibleCells = collectionView!.visibleCells() as? [ParallaxCollectionViewCell] {
            for parallaxCell in visibleCells {
                var yOffset = ((collectionView!.contentOffset.y - parallaxCell.frame.origin.y) / ImageHeight) * OffsetSpeed
                parallaxCell.offset(CGPointMake(0.0, yOffset))
            }
        }
    }


}

