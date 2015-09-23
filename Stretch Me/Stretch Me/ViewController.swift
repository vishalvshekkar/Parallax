//
//  ViewController.swift
//  Stretch Me
//
//  Created by Vishal on 9/23/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 250.0
private let kTableHeaderCutAway: CGFloat = 50.0

class ViewController: UITableViewController {

    
    
    var headerMaskLayer: CAShapeLayer!
    
    let items = [
        NewsItem(category: .World, summary: "Climate change protests, divestments meet fossil fuels realities"),
        NewsItem(category: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        NewsItem(category: .MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
        NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewsItem(category: .Europe, summary: "'One million babies' created by EU student exchanges"),
    ]
    
    var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableViewAutomaticDimension
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: "changeImage")
        headerView.addGestureRecognizer(tap)
        tableView.addSubview(headerView)
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        headerMaskLayer.shadowColor = UIColor.blackColor().CGColor
        headerMaskLayer.shadowOffset = CGSize(width: 0, height: -10)
        headerMaskLayer.shadowOpacity = 0.8
        headerMaskLayer.shadowRadius = 12.0
        headerView.layer.mask = headerMaskLayer
        
        
        updateHeaderView()
        let headerRect = headerView.frame.size
        parallaxEffectOnBackground()
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
        let view = headerView.subviews
        for views in view {
            if views is UIImageView {
                let imageView = views as! UIImageView
                imageView.addMotionEffect(group)
            }
        }
        
    }
    
//    http://blog.matthewcheok.com/design-teardown-stretchy-headers/
    
    func changeImage() {
        let view = headerView.subviews
        for views in view {
            if views is UIImageView {
                let imageView = views as! UIImageView
                if let img = imageView.image {
                    let blackView = UIView(frame: imageView.frame)
                    blackView.backgroundColor = UIColor.blackColor()
                    blackView.alpha == 0.0
                    headerView.addSubview(blackView)
                    headerView.bringSubviewToFront(blackView)
                    let duration: NSTimeInterval = 5.0
                    let im1 = UIImage(named: "City1")
                    let im2 = UIImage(named: "City2")
                    let im3 = UIImage(named: "City3")
                    let im4 = UIImage(named: "City4")
                    UIView.animateWithDuration(duration, animations: { () -> Void in
                        blackView.alpha == 0.9
                        }, completion: { (myBoo) -> Void in
                            blackView.alpha == 0.9
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                if img == im1 {
                                    imageView.image = im2
                                    UIView.animateWithDuration(duration, animations: { () -> Void in
                                        blackView.alpha == 0.1
                                        }, completion: { (myBoo) -> Void in
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                blackView.alpha == 0.1
                                                blackView.removeFromSuperview()
                                            })
                                    })                            }
                                else if img == im2 {
                                    imageView.image = im3
                                    UIView.animateWithDuration(duration, animations: { () -> Void in
                                        blackView.alpha == 0.1
                                        }, completion: { (myBoo) -> Void in
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                blackView.alpha == 0.1
                                                blackView.removeFromSuperview()
                                            })
                                    })
                                }
                                else if img == im3 {
                                    imageView.image = im4
                                    UIView.animateWithDuration(duration, animations: { () -> Void in
                                        blackView.alpha == 0.1
                                        }, completion: { (myBoo) -> Void in
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                blackView.alpha == 0.1
                                                blackView.removeFromSuperview()
                                            })
                                    })
                                }
                                else {
                                    imageView.image = im1
                                    UIView.animateWithDuration(duration, animations: { () -> Void in
                                        blackView.alpha == 0.1
                                        }, completion: { (myBoo) -> Void in
                                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                                blackView.alpha == 0.1
                                                blackView.removeFromSuperview()
                                            })
                                    })
                                }
                            })
                            
                    })
                    
                }
            }
        }
    }
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsItemCell
        cell.newsItem = item
        
        return cell
    }


}

