//
//  TaskTableViewController.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/7/22.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {

    @IBOutlet weak var sample: UIButton!
    @IBOutlet var courseTaskTableView: UITableView!
    var course: Course!
    //= Course(name: "", taskList: [Task(name:"" ,ratio:0)], added: false)
    //var TaskList = ["Assignment1", "Assignment2", "Assignment3", "Midterm1", "Midterm2", "Final"]
    
    //var Value = ["10%", "10%", "10%", "15%", "15%", "40%"]
    
    @IBAction func popSample(sender:AnyObject) {
        
        let alertcontroller = UIAlertController(title: "\n\n\n\n\n\n", message: "\n\n\n\n", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let image = UIImage(named: "sample")
        let imageView = UIImageView(image: image)
        //self.addChildViewController(alertcontroller);
        
        //self.view.addSubview(alertcontroller.view);
        alertcontroller.view.addSubview(imageView)
        //将action添加到视图控制器中
        alertcontroller.addAction(okAction)

        //呈现出视图控制器
       self.presentViewController(alertcontroller, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return course.taskList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Task0", forIndexPath: indexPath) as! TaskTableViewCell

        cell.taskName.text = course.taskList[indexPath.row].name
        cell.ratio.text = "\(course.taskList[indexPath.row].ratio*100)"
        cell.myScore.text = "\(course.taskList[indexPath.row].myScore)"
        cell.totalScore.text = "\(course.taskList[indexPath.row].totalScore)"
        cell.percent.text = "\(course.taskList[indexPath.row].getPercent()*100)%"
        cell.point.text = "\(course.taskList[indexPath.row].getPoint()*100)%"
        
        // Configure the cell...
        //cell.taskName.layer.cornerRadius = 10
        //cell.taskName.clipsToBounds = true
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .Default, title: "Edit") {
            (action, indexPath) -> Void in
            
            let alert = UIAlertController(title: "You want to edit", message: "", preferredStyle: .ActionSheet)
            
            let editMark = UIAlertAction(title: "Your mark", style: .Default, handler: nil)
            
            let editTask = UIAlertAction(title: "This task", style: .Default, handler: nil)
            
            alert.addAction(editMark)
            alert.addAction(editTask)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        //RGB必须除以255
        editAction.backgroundColor = UIColor(red: 218/255, green: 225/255, blue: 218/255, alpha: 1)
        
        let delAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action, indexPath) -> Void in
            self.course.taskList.removeAtIndex(indexPath.row)
            
            
            //Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        return [editAction, delAction]
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
