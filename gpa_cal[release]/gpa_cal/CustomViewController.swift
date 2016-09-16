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
    @IBOutlet weak var prof: UITextField!
    @IBOutlet weak var testNum: UITextField!
    @IBOutlet weak var assignNum: UITextField!
    @IBOutlet weak var quizNum: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    let pickerTerms = ["Year", "Fall", "Winter"]
    let termPR = ["Y", "F", "S"]
    
    var home: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CourseName.layer.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).CGColor
        CourseName.layer.cornerRadius = 10
        prof.layer.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).CGColor
        prof.layer.cornerRadius = 10
        testNum.layer.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).CGColor
        testNum.layer.cornerRadius = 10
        assignNum.layer.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).CGColor
        assignNum.layer.cornerRadius = 10
        quizNum.layer.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).CGColor
        quizNum.layer.cornerRadius = 10
        
        
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
            var tmp = "N/A " + termPR[termPicker.selectedRowInComponent(0)]
            if let name = CourseName.text {
                if name != "" {
                    tmp = CourseName.text! + termPR[termPicker.selectedRowInComponent(0)]
                }
            }
            let c = Course(order: "\(self.home.diyCourses.count)", name: tmp, term: termPR[termPicker.selectedRowInComponent(0)], taskList: [Task(name: "Final", ratio: 0)], added: 1, diy: 1);
            if let p = self.prof.text {
                c.addProf(p)
            }
            if let t = Int(self.testNum.text!) {
                c.addTest(t)
            }
            if let a = Int(self.assignNum.text!) {
                c.addAssign(a)
            }
            if let q = Int(self.quizNum.text!) {
                c.addQuiz(q)
            }
            c.save(c.order)
            destVC.diyCourses.append(c)
            destVC.createAddedCourses()
            destVC.courseTable.reloadData()
            //destVC.course = c
            //destVC.parent = self.home
            
        }
    }



}
