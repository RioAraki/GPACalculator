//
//  Task.swift
//  gpa_cal
//
//  Created by LizheChen on 16/7/28.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var ratio: Double = 0
    var totalScore: Double = 0
    var myScore: Double = 0
    
    
    init(name: String, ratio: Double) {
        self.name = name
        self.ratio = ratio
    }
    
    func toStrList() -> [String] {
        var result = [String]()
        result.append(self.name)
        result.append(String(self.ratio))
        result.append(String(self.myScore))
        result.append(String(self.totalScore))
        return result
    }
    
    
    
    func getPercent() -> Double {
        if totalScore != 0 {
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