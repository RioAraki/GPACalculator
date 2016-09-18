//
//  GuiderPageViewController.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/9/17.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class GuiderPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var images = ["Tutorial", "Tutorial", "Tutorial"]
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuiderContentViewController).index
        
        index += 1
        
        return viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! GuiderContentViewController).index
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> GuiderContentViewController? {
        if case 0 ..< images.count = index {
            if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuiderContentController") as? GuiderContentViewController {
            
                contentVC.imageName = images[index]
                contentVC.index = index
                
                return contentVC
            }
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self;
        if let startVC = viewControllerAtIndex(0) {
            setViewControllers([startVC], direction: .Forward, animated: true, completion: nil)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
