//
//  HomeTableViewCell.swift
//  gpa_cal
//
//  Created by Macbookpro on 16/9/10.
//  Copyright © 2016年 Macbookpro. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
