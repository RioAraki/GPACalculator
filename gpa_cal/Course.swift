//
//  Course.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/7/28.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import Foundation

class Course {
    
    let gradeScore = [90.0, 85.0, 80.0, 77.0, 73.0, 70.0, 67.0, 63.0, 60.0, 57.0, 53.0, 50.0]
    let gradeList = ["A+", "A", "A-", "B+", "B", "B-","C+", "C", "C-","D+", "D", "D-"]
    var name: String
    var taskList = [Task]()
    var added: Bool
    
    init(name: String, taskList: [Task], added: Bool) {
        self.name = name
        self.taskList = taskList
        self.added = added
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
            if task.finished {
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
            if task.finished {
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
            if task.finished {
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
        let diffPercent = (diff / undoTaskRatio) * 100
        
        return "\(target) You still need \(diff) points to achieve \(grade), you need \(diffPercent) % marks of your undo tasks"
    }
    
    
}

//let c1 = Course(name: <#T##String#>, taskList: <#T##[Task]#>, added: <#T##Bool#>)