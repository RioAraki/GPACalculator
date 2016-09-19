//
//  Course.swift
//  gpa_cal
//
//  Created by LizheChen on 16/7/28.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import Foundation

class Course {
    
    let gradeScore = [90.0, 85.0, 80.0, 77.0, 73.0, 70.0, 67.0, 63.0, 60.0, 57.0, 53.0, 50.0]
    let gradeList = ["A+ / 4.0", "A / 4.0", "A- / 3.7", "B+ / 3.3", "B / 3.0", "B- / 2.7","C+ / 2.3", "C / 2.0", "C- / 1.7","D+ / 1.3", "D / 1.0", "D- / 0.7"]
    var order: String
    var term: String
    var name: String
    var taskList = [Task]()
    var added: Int
    var diy: Int
    var prof: String = ""
    
    init(order:String, name: String, term: String, taskList: [Task], added: Int, diy: Int) {
        self.name = name
        self.term = term
        self.taskList = taskList
        self.added = added
        self.order = order
        self.diy = diy
    }
    
    func addProf(name:String) {
        self.prof = name
    }
    
    func addQuiz(num: Int) {
        var i = 0
        while i < num {
            i = i + 1
            self.taskList.append(Task(name: "Quiz " + "\(i)", ratio: 0.0))
        }
    }
    
    func addTest(num: Int) {
        var i = 0
        while i < num {
            i = i + 1
            self.taskList.append(Task(name: "Test " + "\(i)", ratio: 0.0))
        }
    }
    
    func addAssign(num: Int) {
        var i = 0
        while i < num {
            i = i + 1
            self.taskList.append(Task(name: "Assignment " + "\(i)", ratio: 0.0))
        }
    }
    
    func currentMark() -> Double {
        var result = 0.0
        if taskList.count > 0 {
            for task in taskList {
                result += task.getPoint()
            }
        }
        return result
    }
    
    //计算已经完成的course point
    func pastRatio() -> Double {
        var result = 0.0
        for task in taskList {
            if task.totalScore > 0.0 {
                result = result + task.ratio
            }
        }
        return result
    }
    
    func taskListTotalRatio() -> Double {
        var result = 0.0
        if taskList.count > 0 {
            for task in taskList {
                result += task.ratio
            }
        }
        return result
    }
    
    func taskListAmendingChecker(ratio: Double) -> String {
        if ratio == 100 {
            return "the ratio is correct"
        } else if ratio < 100 {
            return "the total ratio is less than 100"
        } else {
            return "the total ratio is greater than 100"
        }
        
    }
    
    
    func getCurrentPoint() -> Double {
        var result = 0.0
        if taskList.isEmpty {
            return result
        }
        for task in taskList {
            if task.totalScore > 0 {
                result += task.getPoint()
            }
            
        }
        return result
    }
    
    
    func getCurrentPercent() -> Double {
        var total = 0.0
        if taskList.isEmpty {
            return total
        }
        for task in taskList {
            if task.totalScore > 0 {
                total += task.ratio
            }
            
        }
        return self.getCurrentPoint() / total
    }
    
    func getCurrentRatio() -> Double {
        var total = 0.0
        if taskList.isEmpty {
            return total
        }
        for task in taskList {
            if task.totalScore > 0 {
                total += task.ratio
            }
            
        }
        return total
    }
    
    func getTargetDiff(grade: String) -> String {
        let index = gradeList.indexOf(grade)
        let target = gradeScore[index!]
        let currentPoint = getCurrentPoint()
        let diff = target - currentPoint
        let undoTaskRatio = 100 - self.getCurrentRatio()
        if diff > undoTaskRatio {
            return "You won't achieve \(grade)/\(target)%"
        } else {
            let diffPercent = (diff / undoTaskRatio) * 100
            let diffStr = String(format: "%.1f", diff)
            let dpStr = String(format: "%.1f", diffPercent)
            return "In order to get a(n) \(grade) / \(target) in this Course\nYou need \(diffStr) points.\n\nYou are recommended to get an average of \(dpStr)% out of all left grade AT Least\n"
        }
        
    }
    
    func getTargetDiffNum(grade: String) -> Double {
        let index = gradeList.indexOf(grade)
        let target = gradeScore[index!]
        let currentPoint = getCurrentPoint()
        let diff = target - currentPoint
        let undoTaskRatio = 100 - self.getCurrentRatio()
        if diff > undoTaskRatio {
            return undoTaskRatio
        } else {
            return diff
        }
        
    }
    
    func save(order: String){
        var result = [String]()
        result.append(self.prof)
        result.append(self.name)
        result.append(self.term)
        result.append("\(self.added)")
        for t in self.taskList {
            result = result + t.toStrList()
        }
        var folder = ""
        if self.diy == 1 {
            folder = "/Documents/diy/diy" + order + ".plist"
        } else {
            folder = "/Documents/preset/preset" + order + ".plist"
        }
        let path = NSHomeDirectory() + folder
        let tmp = result as NSArray
        tmp.writeToFile(path, atomically: true)
        print(path)
    }
    
    
    
}

//let c1 = Course(name: <#T##String#>, taskList: <#T##[Task]#>, added: <#T##Bool#>)