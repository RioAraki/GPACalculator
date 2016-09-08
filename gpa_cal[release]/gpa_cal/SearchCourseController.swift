//
//  SearchCourseController.swift
//  gpa_cal
//
//  Created by LizheChen on 16/7/21.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import UIKit

class SearchCourseController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    
    @IBOutlet weak var searchResult: UITableView!
    var sc: UISearchController!
    
    var presetCourses = [Course]()
    var parent: ViewController = ViewController()
    var sr: [Course] = []
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if var textToSearch = sc.searchBar.text {
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            textToSearch = textToSearch.uppercaseString
            searchFilter(textToSearch)
            searchResult.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return !sc.active
    }
    func searchFilter(textToSearch: String) {
        sr = presetCourses.filter({ (c) -> Bool in
            return c.name.containsString(textToSearch)
        })
        for p in presetCourses{
            print(p.name)
        }
        print("\n\n\n")
        for s in sr{
            print(s.name)
        }
        print("\n")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sc.active {
            return sr.count
        } else {
            return presetCourses.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Result0", forIndexPath: indexPath) as! SearchTableViewCell

        let r : Course
        if sc.active {
            r = sr[indexPath.row]
        } else {
            r = presetCourses[indexPath.row]
        }
        
        if (r.added == 1) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        
        cell.resultName.text = r.name
        
        return cell
    }
    
    //选择了一行后
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Adding
        let r = sc.active ? sr[indexPath.row] : presetCourses[indexPath.row]
        
        let alert = UIAlertController(title: "Add this course to your course list?", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
    
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
       
        //var addedCourse = [String]()
        //for c in self.presetCourses {
         //   addedCourse.append(c.name)
        //}
        
        let addCourse = { (action: UIAlertAction) -> Void in
            
            self.presetCourses[Int(r.order)!].added = 1;
            self.presetCourses[Int(r.order)!].save(self.presetCourses[Int(r.order)!].order)
            
        
            self.parent.presetCourses = self.presetCourses
            self.parent.createAddedCourses()
            self.parent.courseTable.reloadData()
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            let alert = UIAlertController(title: "Notice", message: "Successfully added", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            if self.sc.active {
                self.sc.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            
            
        }
        
        let addCourseAction = UIAlertAction(title: "Add \(presetCourses[Int(r.order)!].name)", style: .Default, handler: addCourse)
        
        alert.addAction(cancelAction)
        alert.addAction(addCourseAction)
        //removing
        let removeAlert = UIAlertController(title: "Remove this course?", message: "", preferredStyle: .ActionSheet)
        
        let removeCourse = { (action: UIAlertAction) -> Void in
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)

            self.presetCourses[Int(r.order)!].added = 0;
            self.presetCourses[Int(r.order)!].save(self.presetCourses[Int(r.order)!].order)
            
            self.parent.presetCourses = self.presetCourses
            self.parent.createAddedCourses()
            self.parent.courseTable.reloadData()
            cell?.accessoryType = UITableViewCellAccessoryType.None
            
            let alert = UIAlertController(title: "Notice", message: "Successfully removed", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            
            if self.sc.active {
                self.sc.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        
        let removeCourseAction = UIAlertAction(title: "Remove \(presetCourses[Int(r.order)!].name)", style: .Default, handler: removeCourse)
        
        removeAlert.addAction(cancelAction)
        removeAlert.addAction(removeCourseAction)
        
        var finalAlert: UIAlertController
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
            finalAlert = removeAlert
        } else {
            finalAlert = alert
        }
        
        if self.sc.active {
            self.sc.presentViewController(finalAlert, animated: true, completion: nil)
        } else {
            self.presentViewController(finalAlert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sc = UISearchController(searchResultsController: nil)
        searchResult.tableHeaderView = sc.searchBar
        sc.searchBar.placeholder = "e.g. CSC108F"
        sc.searchBar.searchBarStyle = .Minimal
        sc.searchResultsUpdater = self
        
        sc.dimsBackgroundDuringPresentation = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("alibaba1")
        if segue.identifier == "showCustom"{
           let destVC = segue.destinationViewController as! CustomViewController
            destVC.home = self.parent
        }
        
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
}