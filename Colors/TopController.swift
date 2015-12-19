//
//  TopController.swift
//  Colors
//
//  Created by me on 12/19/15.
//  Copyright © 2015 YutaroTanaka. All rights reserved.
//

import UIKit

class TopController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageIndexes: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = NSArray(objects: "Red", "Blue", "Green", "Yellow", "Black")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ColorPageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        self.initStartView()
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
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
        
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
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
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
