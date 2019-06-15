//
//  MyPastOrdersTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 16.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyPastOrdersTableViewCell: UITableViewCell {


    @IBOutlet weak var pastOrderNumber: UILabel!
    @IBOutlet weak var pastOrderDate: UILabel!
    @IBOutlet weak var pastOrderPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
