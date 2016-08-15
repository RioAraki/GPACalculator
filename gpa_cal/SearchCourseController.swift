//
//  SearchCourseController.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/7/21.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class SearchCourseController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var resultList = ["MAT133Y", "CSC108F", "ECO100Y", "MAT135F", "CSC165F", "MAT223F", "BIO120F","CSC148S", "MAT224S", "MAT136S", "BIO130S", "MAT137Y", "MAT157Y", "MAT138Y", "BIO120F", "BIO130S"]
    var CourseList = [Course]()
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Result0", forIndexPath: indexPath) as! SearchTableViewCell
        var addedCourse = [String]()
        for c in self.CourseList {
            addedCourse.append(c.name)
        }
        if (addedCourse.contains(resultList[indexPath.row])) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        
        cell.resultName.text = resultList[indexPath.row]
        
        return cell
    }
    
    //选择了一行后
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Adding
        let alert = UIAlertController(title: "Add this course to your course list?", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
       
        var addedCourse = [String]()
        for c in self.CourseList {
            addedCourse.append(c.name)
        }
        
        let addCourse = { (action: UIAlertAction) -> Void in
            
            addedCourse.append(self.resultList[indexPath.row])
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            let alert = UIAlertController(title: "Notice", message: "Successfully added", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        let addCourseAction = UIAlertAction(title: "Add \(resultList[indexPath.row])", style: .Default, handler: addCourse)
        
        alert.addAction(cancelAction)
        alert.addAction(addCourseAction)
        //removing
        let removeAlert = UIAlertController(title: "Remove this course?", message: "", preferredStyle: .ActionSheet)
        
        let removeCourse = { (action: UIAlertAction) -> Void in
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)

            var addedCourse = [String]()
            for c in self.CourseList {
                addedCourse.append(c.name)
            }
            let index = addedCourse.indexOf(self.resultList[indexPath.row])
            addedCourse.removeAtIndex(index!)
            
            cell?.accessoryType = UITableViewCellAccessoryType.None
            
            let alert = UIAlertController(title: "Notice", message: "Successfully removed", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)

            
        }
        
        let removeCourseAction = UIAlertAction(title: "Remove \(resultList[indexPath.row])", style: .Default, handler: removeCourse)
        
        removeAlert.addAction(cancelAction)
        removeAlert.addAction(removeCourseAction)
        
        var finalAlert: UIAlertController
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            finalAlert = removeAlert
        } else {
            finalAlert = alert
        }
        
        self.presentViewController(finalAlert, animated: true, completion: nil)
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