//
//  Task.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/7/28.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var ratio: Double = 0
    var totalScore: Double = 0
    var myScore: Double = 0
    var finished: Bool = false
    
    init(name: String, ratio: Double) {
        self.name = name
        self.ratio = ratio
    }
    
    func getPercent() -> Double {
        if finished {
            return myScore / totalScore
        } else {
            return 0
        }
        
    }
    
    func getPoint() -> Double {
        return getPercent() * ratio
    }
}

//let t1 = Task(name: <#T##String#>, ratio: Double, totalScore: <#T##Double#>, myScore: <#T##Double#>, finished: <#T##Bool#>)