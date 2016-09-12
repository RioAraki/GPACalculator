//
//  CustomViewController.swift
//  gpa_cal
//
//  Created by LizheChen on 16/8/19.
//  Copyright © 2016年 LizheChen. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var termPicker: UIPickerView!
    @IBOutlet weak var CourseName: UITextField!
    let pickerTerms = ["Year", "Fall", "Winter"]
    let termPR = ["Y", "F", "S"]
    
    var home: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomViewController.DismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    
    func DismissKeyboard(){
        self.view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTerms.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerTerms[row]
    }
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "checkNewDIY" {
            let destVC = segue.destinationViewController as! ViewController
            var tmp = "N/A"
            if let name = CourseName.text {
                tmp = name + termPR[termPicker.selectedRowInComponent(0)]
            }
            let c = Course(order: "\(self.home.diyCourses.count)", name: tmp, term: termPR[termPicker.selectedRowInComponent(0)], taskList: [Task(name: "Final", ratio: 0)], added: 1, diy: 1)
            c.save(c.order)
            destVC.diyCourses.append(c)
            destVC.createAddedCourses()
            destVC.courseTable.reloadData()
            //destVC.course = c
            //destVC.parent = self.home
            
        }
    }



}
