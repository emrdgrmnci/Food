//
//  DetailFoodTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class DetailFoodTableViewCell: UITableViewCell {

    @IBOutlet weak var detailFoodNameLabel: UILabel!
    @IBOutlet weak var detailFoodNameSubLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
