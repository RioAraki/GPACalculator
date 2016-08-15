//
//  ViewController.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/7/8.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var CourseList = [
        Course(name: "CSC108F", taskList: [Task(name:"CSC108Fquiz" ,ratio:10/100), Task(name: "CSC108Fmid" ,ratio:40/100), Task(name:"CSC108Ffinal",ratio:50/100)], added: true),
        Course(name: "ECO100Y", taskList: [Task(name:"ECO100Yquiz" ,ratio:10/100), Task(name: "ECO100Ymid" ,ratio:40/100), Task(name:"ECO100Yfinal",ratio:50/100)], added: true),
        Course(name: "MAT135F", taskList: [Task(name:"MAT135Fquiz" ,ratio:10/100), Task(name: "MAT135Fmid" ,ratio:40/100), Task(name:"MAT135Ffinal",ratio:50/100)], added: true),
        Course(name: "CSC165F", taskList: [Task(name:"CSC165Fquiz" ,ratio:10/100), Task(name: "CSC165Fmid" ,ratio:40/100), Task(name:"CSC165Ffinal",ratio:50/100)], added: true),
        Course(name: "MAT223F", taskList: [Task(name:"MAT223Fquiz" ,ratio:10/100), Task(name: "MAT223Fmid" ,ratio:40/100), Task(name:"MAT223Ffinal",ratio:50/100)], added: true),
        Course(name: "BIO120F", taskList: [Task(name:"BIO120Fquiz" ,ratio:10/100), Task(name: "BIO120Fmid" ,ratio:40/100), Task(name:"BIO120Ffinal",ratio:50/100)], added: true),
        Course(name: "CSC148S", taskList: [Task(name:"CSC148Squiz" ,ratio:10/100), Task(name: "CSC148Smid" ,ratio:40/100), Task(name:"CSC148Sfinal",ratio:50/100)], added: true),
        Course(name: "MAT224S", taskList: [Task(name:"MAT224Squiz" ,ratio:10/100), Task(name: "MAT224Smid" ,ratio:40/100), Task(name:"MAT224Sfinal",ratio:50/100)], added: true),
        Course(name: "MAT136S", taskList: [Task(name:"MAT136Squiz" ,ratio:10/100), Task(name: "MAT136Smid" ,ratio:40/100), Task(name:"MAT136Sfinal",ratio:50/100)], added: true),
        Course(name: "BIO130S", taskList: [Task(name:"BIO130Squiz" ,ratio:10/100), Task(name: "BIO130Smid" ,ratio:40/100), Task(name:"BIO130Sfinal",ratio:50/100)], added: true)
    ]
    
    
    @IBOutlet weak var courseTable: UITableView!
    //表格区块里有多少个单元格
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourseList.count
    }
    
    //表格相应位置的单元格，显示哪些内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Course0", forIndexPath: indexPath)

        cell.textLabel!.text = CourseList[indexPath.row].name + "    100%"

        //添加图片，测试用，可删除
        //cell.imageView?.image = UIImage(named: "grades")

        
        return cell
    }
    
    //隐藏状态条（可删除）
    /*override func prefersStatusBarHidden() -> Bool {
        return true
    }*/
    
    // Override to support editing the table view.
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
        self.CourseList.removeAtIndex(indexPath.row)
        
        //tableView.reloadData()
        // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showCourseDetails") {
            let destVC = segue.destinationViewController as! TaskTableViewController
            //需要测试
            destVC.course = CourseList[courseTable.indexPathForSelectedRow!.row]
        } else if (segue.identifier == "showSearchView") {
            let destVC = segue.destinationViewController as! SearchCourseController
            
            destVC.CourseList = CourseList
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

