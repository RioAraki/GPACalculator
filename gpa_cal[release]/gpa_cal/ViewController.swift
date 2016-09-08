//
//  ViewController.swift
//  gpa_cal
//
//  Created by LizheChen on 16/7/8.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var addedCourses = [Course]()
    var presetCourses = [Course]()
    var diyCourses = [Course]()
    
    
    @IBOutlet weak var courseTable: UITableView!
    //表格区块里有多少个单元格
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //需要修改
        return addedCourses.count
    }
    
    //表格相应位置的单元格，显示哪些内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Course0", forIndexPath: indexPath)
        //需要修改
        cell.textLabel!.text = addedCourses[indexPath.row].name + "    " + String(format: "%.2f", addedCourses[indexPath.row].currentMark()) + "%"

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
        let tmp = addedCourses[indexPath.row]
        if tmp.diy == 0 {
            presetCourses[Int(tmp.order)!].added = 0
            presetCourses[Int(tmp.order)!].save(tmp.order)
        } else if tmp.diy == 1 {
            self.diyCourses.removeAtIndex(Int(tmp.order)!)
            let fileManager = NSFileManager.defaultManager()
            let myDirectory = NSHomeDirectory() + "/Documents/diy"
            try! fileManager.removeItemAtPath(myDirectory)
            try! fileManager.createDirectoryAtPath(myDirectory, withIntermediateDirectories: true, attributes: nil)
            saveList(diyCourses)
        }
        self.addedCourses.removeAtIndex(indexPath.row)
        
        //tableView.reloadData()
        // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showCourseDetails") {
            let destVC = segue.destinationViewController as! TaskListViewController
            //需要测试
            destVC.course = addedCourses[courseTable.indexPathForSelectedRow!.row]
            //destVC.index = courseTable.indexPathForSelectedRow!.row
            destVC.parent = self
            destVC.barFlag = true
            
        } else if (segue.identifier == "showSearchView") {
            let destVC = segue.destinationViewController as! SearchCourseController
            //destVC.addedCourses = addedCourses
            //需要把 preset做成可以不sort
            destVC.presetCourses = presetCourses.sort({$0.name < $1.name})
            destVC.parent = self
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "2016 Winter"
        
        //saveList(presetCourses.sort({$0.name < $1.name}))
        //saveList(diyCourses.sort({$0.name < $1.name}))
        //create preset and diy folders

        
        let fileManager = NSFileManager.defaultManager()
        let presetFolder = NSHomeDirectory() + "/Documents/diy/"
        
        let diyFolder = NSHomeDirectory() + "/Documents/preset"
        let presetBool = fileManager.fileExistsAtPath(presetFolder)
        let diyBool = fileManager.fileExistsAtPath(diyFolder)
        if !presetBool {
            try! fileManager.createDirectoryAtPath(presetFolder, withIntermediateDirectories: true, attributes: nil)
            
        }
        presetCourses = loadPreset()
        if !diyBool {
            try! fileManager.createDirectoryAtPath(diyFolder, withIntermediateDirectories: true, attributes: nil)
        } else if diyCourses.isEmpty {
            diyCourses =  loadDIY()
        }
        if addedCourses.isEmpty {
            createAddedCourses()
        }
        //back button style
       navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        saveList(presetCourses.sort({$0.name < $1.name}))
        NSThread.sleepForTimeInterval(3.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //file loading funcs
    
    func createAddedCourses() {
        var resultY = [Course]()
        var resultF = [Course]()
        var resultS = [Course]()
        for p in presetCourses {
            if (p.added == 1) {
                if p.term == "Y" {
                    resultY.append(p)
                } else if p.term == "F" {
                    resultF.append(p)
                } else if p.term == "S" {
                    resultS.append(p)
                }
            }
        }
        for d in diyCourses {
            if (d.added == 1) {
                if d.term == "Y" {
                    resultY.append(d)
                } else if d.term == "F" {
                    resultF.append(d)
                } else if d.term == "S" {
                    resultS.append(d)
                }
            }

        }
        
        resultY = resultY.sort({$0.name < $1.name})
        resultF = resultF.sort({$0.name < $1.name})
        resultS = resultS.sort({$0.name < $1.name})
        
        self.addedCourses = resultY + resultF + resultS
        
    }
    
    func toTask(list:[String]) -> Task {
        let name = list[0]
        let ratio: Double = (list[1] as NSString).doubleValue
        let result = Task(name: name, ratio: ratio)
        result.myScore = (list[2] as NSString).doubleValue
        result.totalScore = (list[3] as NSString).doubleValue
        return result
        
        
    }
    
    func loading(list: [String], order: String, diy: Int) -> Course {
        print(list[0])
        let result = Course(order: order, name: list[0], term: list[1], taskList: [Task](), added: Int(list[2])!, diy: diy)
        var index: Int = 3
        var tmp:[String];
        while index < list.count {
            tmp = [list[index]] + [list[index+1]] + [list[index+2]] + [list[index+3]]
            
            result.taskList.append(toTask(tmp))
            index = index + 4
            
        }
        
        return result
    }
    
    
    
    func loadPreset() -> [Course]{
        var result = [Course]()
        let path =  NSHomeDirectory() + "/Documents/preset"
        print(path)
        let manager = NSFileManager.defaultManager()
        let contentInPath = try? manager.contentsOfDirectoryAtPath(path)
        
        print(contentInPath)
        let countFile = contentInPath?.count
        var index = 0
        print("preset")
        var tmpList = []
        if (countFile > 0) {
            print("A")
            while index < (countFile!) {
                tmpList = NSArray(contentsOfFile: path + "/preset\(index).plist")!
                result.append(self.loading(tmpList as! [String], order: "\(index)", diy: 0))
                index = index + 1
            }
         
        } else {
            let plists = NSBundle.mainBundle().pathsForResourcesOfType("plist", inDirectory: "preset")
            for f in plists {
                tmpList = NSArray(contentsOfFile: f)!
                result.append(self.loading(tmpList as! [String], order: "\(index)", diy: 0))
                index = index + 1
            }
            
        }
      
        print(index)
        return result
    }
    
    func loadDIY() -> [Course]{
        var result = [Course]()
        let path =  NSHomeDirectory() + "/Documents/diy"
        print(path)
        let manager = NSFileManager.defaultManager()
        
        var countFile: Int? = 0
        if let contentInPath = try? manager.contentsOfDirectoryAtPath(path) {
            print(contentInPath)
            countFile = contentInPath.count
        }
        var index = 0
        print("DIY")
        var tmpList = []
        if (countFile > 0) {
        while index < (countFile!) {
            tmpList = NSArray(contentsOfFile: path + "/diy\(index).plist")!
            result.append(self.loading(tmpList as! [String], order: "\(index)", diy: 1))
            index = index + 1
        }
        }
        print(index)
        return result
    }

    func saveList(list: [Course]) {
        var index = 0
        for c in list {
            c.save("\(index)")
            print(c.name)
            index = index + 1
        }
    }
    
    

}

