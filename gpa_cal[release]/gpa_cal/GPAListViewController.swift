//
//  GPAListViewController.swift
//  gpa_cal
//
//  Created by LizheChen on 16/8/15.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import UIKit

class GPAListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var course: Course!
    
    @IBOutlet weak var overview: UILabel!
    @IBOutlet var GPAList: UITableView!
    //@IBOutlet weak var chartView: UIView!
    @IBOutlet weak var gpaChart: UIView!
    
    override func viewDidLoad() {
        GPAList.estimatedRowHeight = 100
        GPAList.rowHeight = UITableViewAutomaticDimension
        
        overview.text = "You still have \(100 - course.pastRatio())% left.\nXXX Chart";
        
        let chart = getBarChart()
        chart.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 0.98)
        chart.strokeChart()
        gpaChart.addSubview(chart)
        gpaChart.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 255/255, alpha: 0.98)
        gpaChart.contentMode = .ScaleToFill
       // self.view.addSubview(chart)
        
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    func getBarChart() -> PDBarChart{
        let dataItem: PDBarChartDataItem = PDBarChartDataItem()
        dataItem.xMax = 12.0
        dataItem.xInterval = 1.0
        dataItem.yMax = CGFloat(100 - course.getCurrentRatio())
        dataItem.yInterval = CGFloat(dataItem.yMax / 10)
        var xValue = 1.0
        var temp = [CGPoint]()
        for grade in course.gradeList {
            temp.append(CGPoint(x: CGFloat(xValue), y: CGFloat(course.getTargetDiffNum(grade))))
            xValue = xValue + 1.0
        }
        dataItem.barPointArray = temp
        
        dataItem.xAxesDegreeTexts = ["A+", "4.0", "3.7", "3.3", "3.0", "2.7","2.3", "2.0", "1.7","1.3", "1.0", "0.7"]
        //dataItem.yAxesDegreeTexts = ["100", "90", "80", "70", "60", "50", "40", "30", "20", "10"]
        let barChart: PDBarChart = PDBarChart(frame: CGRectMake(0, 0, 350, 250), dataItem: dataItem)
        return barChart
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.gradeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GPAListCell", forIndexPath: indexPath) as! GPAListTableViewCell
        cell.decribe.text = "\(course.getTargetDiff(course.gradeList[indexPath.row]))"
        return cell
    }

    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
