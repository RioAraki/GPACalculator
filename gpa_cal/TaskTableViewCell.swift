//
//  TaskTableViewCell.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/7/22.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var myScore: UITextField!
    @IBOutlet weak var totalScore: UITextField!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var ratio: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
