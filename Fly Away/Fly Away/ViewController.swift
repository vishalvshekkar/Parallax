//
//  ViewController.swift
//  Fly Away
//
//  Created by Vishal on 9/24/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    let flyingCellSize = CGSize(width: 94, height: 144)
    
    var flyingView = UIView()
    
    var imageNameArray = [String]()
    
    var viewArray = [UIView]()
    
    var makeItBlack = UIView(frame: CGRect(x: 0, y: 0, width: 94, height: 144))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeItBlack.backgroundColor = UIColor.blackColor()
        for i in 1...33 {
            imageNameArray.append("\(i)")
        }
        for i in 1...10 {
            let viewToAppend = UIView(frame: CGRect(x: 0.0, y: 0.0, width: flyingCellSize.width, height: flyingCellSize.height))
            var color = getRandomColor()
            if color == UIColor.blackColor() {
                color = UIColor.whiteColor()
            }
            viewToAppend.backgroundColor = color
            viewArray.append(viewToAppend)
        }
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.delegate = self
        
        let topLayout = UICollectionViewFlowLayout()
        topLayout.scrollDirection = .Horizontal
        topLayout.minimumInteritemSpacing = 0.0
        topLayout.itemSize = CGSize(width: 150, height: 200)
        topCollectionView.setCollectionViewLayout(topLayout, animated: true)
        
        let bottomLayout = UICollectionViewFlowLayout()
        bottomLayout.scrollDirection = .Horizontal
        bottomLayout.minimumLineSpacing = 20.0
        bottomLayout.minimumInteritemSpacing = 50.0
        bottomLayout.itemSize = flyingCellSize
        bottomCollectionView.setCollectionViewLayout(bottomLayout, animated: true)
    }
    
    
    
    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topCollectionView {
            return viewArray.count
        }
        else {
            print("count Of Cells")
            
            print(imageNameArray.count)
            return imageNameArray.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == topCollectionView {
            let card = topCollectionView.dequeueReusableCellWithReuseIdentifier("Card", forIndexPath: indexPath) as! topCVCellCollectionViewCell
            card.displayView = viewArray[indexPath.row]
            return card
        }
        else {
            bottomCVCell.target = self
            let bottomCard = bottomCollectionView.dequeueReusableCellWithReuseIdentifier("bottomCard", forIndexPath: indexPath) as! bottomCVCell
            let viewsIn = bottomCard.subviews
            for vs in viewsIn {
                if vs.backgroundColor == UIColor.blackColor() {
                    vs.removeFromSuperview()
                }
            }
            bottomCard.bottomImageView.image = UIImage(named: imageNameArray[indexPath.row])
            print(indexPath.row)
            return bottomCard
        }
    }
    
    func didDrag(sender: UIButton) {
        print("Yo, you touched me!")
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == bottomCollectionView {
            let bottomSelectedCard = collectionView.cellForItemAtIndexPath(indexPath) as! bottomCVCell
            bottomSelectedCard.addSubview(makeItBlack)
            let selectedCellOrigin = bottomSelectedCard.frame.origin
            print(selectedCellOrigin)
            let pointOnScreen = collectionView.convertPoint(selectedCellOrigin, toView: self.view)
            let viewToSetFlightOn = bottomSelectedCard.bottomHolder
            startFlight(pointOnScreen, cellView: viewToSetFlightOn, indexPath: indexPath)
        }
    }
    
    func startFlight(origin: CGPoint, cellView: UIView, indexPath: NSIndexPath) {
        print(origin)
        let selectedFrame = CGRect(x: origin.x, y: origin.y, width: flyingCellSize.width, height: flyingCellSize.height)
        let blackFrame = UIView(frame: selectedFrame)
        blackFrame.backgroundColor = UIColor.blackColor()
        self.view.addSubview(blackFrame)
        cellView.frame.origin = CGPoint(x: 0.0, y: 0.0)
        let flyingView1 = UIView(frame: CGRect(x: selectedFrame.origin.x, y: selectedFrame.origin.y, width: flyingCellSize.width, height: flyingCellSize.height))
        cellView.frame.origin = CGPointZero
        UIGraphicsBeginImageContext(cellView.bounds.size);
        cellView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: flyingCellSize.width, height: flyingCellSize.height))
        imageView.image = screenShot
        flyingView1.addSubview(imageView)
        self.view.addSubview(flyingView1)
        self.view.bringSubviewToFront(flyingView1)
        
        let indexPaths = self.topCollectionView.indexPathsForVisibleItems()
        let blackView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.flyingCellSize.width, height: self.flyingCellSize.height))
        blackView.backgroundColor = UIColor.blackColor()
        var leastindexPath = indexPaths[0]
        for indices in indexPaths {
            if indices.item <= leastindexPath.item {
                leastindexPath = indices
            }
        }
        print(leastindexPath.item)
        self.viewArray.insert(blackView, atIndex: leastindexPath.item + 1)
        self.topCollectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: leastindexPath.item + 1, inSection: leastindexPath.section)])
        self.topCollectionView.reloadData()
        let cardAdded = self.topCollectionView.cellForItemAtIndexPath(NSIndexPath(forItem: leastindexPath.item + 1, inSection: leastindexPath.section)) as! topCVCellCollectionViewCell
        let originOfCardAdded = cardAdded.frame.origin
        var pointOnScreen = self.topCollectionView.convertPoint(originOfCardAdded, toView: self.view)
        pointOnScreen = CGPoint(x: pointOnScreen.x + 28, y: pointOnScreen.y + 28)
        print("pointOnScreen")
        print(pointOnScreen)
        
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            flyingView1.frame = CGRect(x: pointOnScreen.x, y: pointOnScreen.y, width: self.flyingCellSize.width, height: self.flyingCellSize.height)
            
            }) { (myBoo) -> Void in
//                self.flyingView.frame.origin = CGPoint(x: 100, y: 100)
                print(self.flyingView.frame)
                self.imageNameArray.removeAtIndex(indexPath.row)
                self.bottomCollectionView.deleteItemsAtIndexPaths([indexPath])
                
                
//                let contentOffset = self.bottomCollectionView.contentOffset
//                self.bottomCollectionView.reloadSections(NSIndexSet(index: 0))
                
                let someView = imageView
                someView.frame.origin = CGPointZero
                self.viewArray[leastindexPath.item + 1] = someView
                self.topCollectionView.reloadData()
                blackFrame.removeFromSuperview()
//                self.makeItBlack.removeFromSuperview()
//                self.bottomCollectionView.scrollRectToVisible(CGRect(x: contentOffset.x, y: contentOffset.y, width: 1, height: 1), animated: true)
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.15 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
//
//                }
                
                
        }
    }
    


}

