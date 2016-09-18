//
//  GuiderContentViewController.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/9/17.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class GuiderContentViewController: UIViewController {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    @IBOutlet weak var tutImageView: UIImageView!
    
    @IBAction func doneBtnTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        let def = NSUserDefaults.standardUserDefaults()
        def.setBool(true, forKey: "guideShowed")

    }
    
    var index = 0
    var imageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        pageCtrl.currentPage = index
        tutImageView.image = UIImage(named: imageName)
        
        if index == 2 {
            doneBtn.hidden = false
            doneBtn.setTitle("Try Now", forState: .Normal)
        } else {
            doneBtn.hidden = true
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
