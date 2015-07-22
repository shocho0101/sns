//
//  TableViewCell.swift
//  sns
//
//  Created by 張翔 on 2015/07/22.
//  Copyright (c) 2015年 sho. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet  var postTextView: UITextView!
    @IBOutlet  var timestampTextLabel: UILabel!
    @IBOutlet  var usernameTextLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
