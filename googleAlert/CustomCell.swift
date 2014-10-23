//
//  CustomCell.swift
//  googleAlert
//
//  Created by naoyashiga on 2014/10/18.
//  Copyright (c) 2014年 naoyashiga. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var siteNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
