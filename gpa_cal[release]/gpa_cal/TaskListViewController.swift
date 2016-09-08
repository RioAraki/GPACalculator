//
//  TaskListViewController.swift
//  gpa_cal
//
//  Created by LizheChen on 16/8/16.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var fakeTitle: UILabel!
    @IBOutlet weak var fakeNaviBar: UIView!
    @IBOutlet weak var TaskTable: UITableView!
    
    @IBOutlet weak var earnedMark: UILabel!
    @IBOutlet weak var past: UILabel!
    @IBOutlet weak var effort: UILabel!
    
   
    
    
    var course: Course!
    var barFlag = true
    var parent: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if barFlag {
            fakeNaviBar.hidden = true
        } else {
            fakeNaviBar.hidden = false
            fakeTitle.text = course.name
        }
        TaskTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        
        title = course.name
        earnedMark.text = String(format:"%.2f",course.getCurrentPoint());
        past.text = String(format:"%.2f",course.pastRatio());
        if course.pastRatio() > 0 {
            effort.text = String(format:"%.2f",(course.getCurrentPoint()/course.pastRatio())*100) + "%"
        } else {
            effort.text = "0.0%"
        }
        
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TaskListViewController.DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    func DismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func reloadSummary() {
        earnedMark.text = String(format:"%.2f",course.getCurrentPoint());
        past.text = String(format:"%.2f",course.pastRatio());
        if course.pastRatio() > 0 {
            effort.text = String(format:"%.2f",(course.getCurrentPoint()/course.pastRatio())*100) + "%"
        } else {
            effort.text = "0.0%"
        }
        if course.diy == 1 {
            parent.diyCourses[Int(course.order)!] = course
        } else if course.diy == 0{
            parent.presetCourses[Int(course.order)!] = course
        }
        course.save(course.order)
        parent.createAddedCourses()
        parent.courseTable.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.taskList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Task0", forIndexPath: indexPath) as! TaskTableViewCell
        cell.selectionStyle = .None
        
        cell.taskName.text = course.taskList[indexPath.row].name
        cell.taskName.placeholder = "Name"
        cell.taskName.tag = indexPath.row
        cell.ratio.text = cellDisplayHelper((course.taskList[indexPath.row].ratio));
        cell.ratio.tag = indexPath.row
        cell.myScore.text = cellDisplayHelper((course.taskList[indexPath.row].myScore))
        cell.myScore.tag = indexPath.row
        cell.totalScore.text = cellDisplayHelper((course.taskList[indexPath.row].totalScore))
        cell.totalScore.tag = indexPath.row
        cell.percent.text = String(format:"%.2f",(course.taskList[indexPath.row].getPercent()*100)) + "%"
        cell.point.text = String(format:"%.2f %",(course.taskList[indexPath.row].getPoint())) + "%"
        //cell.backgroundColor = UIColor.clearColor()
        
        // Configure the cell...
        //cell.taskName.layer.cornerRadius = 10
        //cell.taskName.clipsToBounds = true
        
        
        return cell

    }
    
    func cellDisplayHelper(enter: Double) -> String{
        if enter == 0 {
            return "0"
        } else {
            return String(format:"%.2f", enter)
        }
    }
    
    //amending the content of the cell in TaskTable
    
    @IBAction func editTaskName(sender: UITextField) {
        course.taskList[sender.tag].name = sender.text!
        TaskTable.reloadData()
        self.reloadSummary()
        //course.save("\(self.index)")
    }
    
    @IBAction func editTaskMyScore(sender: UITextField) {
        let strVar = sender.text!
        let str = NSString(string: strVar)
        
        course.taskList[sender.tag].myScore = str.doubleValue;
        TaskTable.reloadData()
        
        self.reloadSummary()
        //course.save("\(self.index)")
    }
    
    @IBAction func editTaskTotalScore(sender: UITextField) {
        let strVar = sender.text!
        let str = NSString(string: strVar)
        
        course.taskList[sender.tag].totalScore = str.doubleValue;
        TaskTable.reloadData()
        
        self.reloadSummary()
        //course.save("\(self.index)")
    }
    
    @IBAction func editTaskRatio(sender: UITextField) {
        let strVar = sender.text!
        let str = NSString(string: strVar)
        
        course.taskList[sender.tag].ratio = str.doubleValue;
        TaskTable.reloadData()
        
        self.reloadSummary()
        //course.save("\(self.index)")
    }

    
    //add new task
    @IBAction func addTask(sender:AnyObject) {
        course.taskList.append(Task(name: "", ratio: 0));
        TaskTable.reloadData()
        course.save(course.order)
    }
    
    //pop a sample of task
    @IBAction func popSample() {
        
        let alertcontroller = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: "\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)

        let def = NSUserDefaults.standardUserDefaults()
        def.setBool(true, forKey: "guideShowed")
        let image = UIImage(named: "Tutorial")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 270, height: 430)
        //self.addChildViewController(alertcontroller);
        
        //self.view.addSubview(alertcontroller.view);
        alertcontroller.view.addSubview(imageView)
        //将action添加到视图控制器中
        alertcontroller.addAction(okAction)
        
        //呈现出视图控制器
        self.presentViewController(alertcontroller, animated: true, completion: nil)
    }

    

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        /*let editAction = UITableViewRowAction(style: .Default, title: "Edit") {
            (action, indexPath) -> Void in
            
            let alert = UIAlertController(title: "You want to edit", message: "", preferredStyle: .ActionSheet)
            
            let editMark = UIAlertAction(title: "Your mark", style: .Default, handler: nil)
            
            let editTask = UIAlertAction(title: "This task", style: .Default, handler: nil)
            
            alert.addAction(editMark)
            alert.addAction(editTask)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        //RGB必须除以255
        editAction.backgroundColor = UIColor(red: 218/255, green: 225/255, blue: 218/255, alpha: 1)*/
        
        let delAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action, indexPath) -> Void in
            self.course.taskList.removeAtIndex(indexPath.row)
            self.course.save(self.course.order)
            
            //Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        return [delAction]    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showGPAList") {
            let destVC = segue.destinationViewController as! GPAListViewController
            
            destVC.course = self.course
        } else {
            //let destVC = parent
            
            /*if self.course.diy == 0 {
                destVC.presetCourses[self.index] = self.course
            } else if self.course.diy == 1 {
                destVC.diyCourses[self.index] = self.course
            }*/
            //destVC.addedCourses[self.index] = self.course
            //destVC.courseTable.reloadData()
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let def = NSUserDefaults.standardUserDefaults()
        if !def.boolForKey("guideShowed") {
            self.popSample()
        }
        
        
    }
   

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}