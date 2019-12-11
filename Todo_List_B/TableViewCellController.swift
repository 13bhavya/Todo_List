//
//  TableViewCellController.swift
//  Project Name: Todo_List_B
//  Name : Bhavya Shah
//  Student Id: 301076681
//  Developing Todo list

//
//  Created by student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var showTask: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
