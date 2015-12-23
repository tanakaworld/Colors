//
//  ColorTopController.swift
//  Colors
//
//  Created by me on 12/19/15.
//  Copyright © 2015 YutaroTanaka. All rights reserved.
//

import UIKit

class ColorTopController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: [String]!
    var pageIndexes: [Int]!
    var colors: [UIColor]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO Extract to Color Objects
        self.pageTitles = [
            "TURQUOISE",
            "EMERALD",
            "PETER RIVER",
            "AMETHYST",
            "WET ASPHALT",
            "GREEN SEA",
            "NEPHRITIS",
            "BELIZE HOLE",
            "WISTERIA",
            "MIDNIGHT BLUE",
            "SUN FLOWER",
            "CARROT",
            "ALIZARIN",
            "CLOUDS",
            "CONCRETE",
            "ORANGE",
            "PUMPKIN",
            "POMEGRANATE",
            "SILVER",
            "ASBESTOS"
        ]
        self.colors = [
            UIColor.hexStr("#1abc9c", alpha: 1),
            UIColor.hexStr("#2ecc71", alpha: 1),
            UIColor.hexStr("#3498db", alpha: 1),
            UIColor.hexStr("#9b59b6", alpha: 1),
            UIColor.hexStr("#34495e", alpha: 1),
            UIColor.hexStr("#16a085", alpha: 1),
            UIColor.hexStr("#27ae60", alpha: 1),
            UIColor.hexStr("#2980b9", alpha: 1),
            UIColor.hexStr("#8e44ad", alpha: 1),
            UIColor.hexStr("#2c3e50", alpha: 1),
            UIColor.hexStr("#f1c40f", alpha: 1),
            UIColor.hexStr("#e67e22", alpha: 1),
            UIColor.hexStr("#e74c3c", alpha: 1),
            UIColor.hexStr("#ecf0f1", alpha: 1),
            UIColor.hexStr("#95a5a6", alpha: 1),
            UIColor.hexStr("#f39c12", alpha: 1),
            UIColor.hexStr("#d35400", alpha: 1),
            UIColor.hexStr("#c0392b", alpha: 1),
            UIColor.hexStr("#bdc3c7", alpha: 1),
            UIColor.hexStr("#7f8c8d", alpha: 1)
        ]
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ColorPageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        self.initStartView()
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func initStartView() {
        let startVc = self.viewControllerAtIndex(0) as ColorViewController
        let viewControllers = NSArray(object: startVc)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
    }
    
    override func  didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startColors(sender: AnyObject) {
        self.initStartView()
    }
    
    func viewControllerAtIndex(index: Int) -> ColorViewController {
        if (self.pageTitles.count == 0 || index >= self.pageTitles.count) {
            return ColorViewController()
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ColorViewController") as! ColorViewController
        
        vc.titleText = self.pageTitles[index] 
        vc.pageIndex = index
        vc.view.backgroundColor = self.colors[index]
        
        return vc
    }

    // MARK: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        let vc = viewController as! ColorViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        --index
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ColorViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        ++index
        
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
}
