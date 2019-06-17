//
//  MyFavoritesTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 15.06.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyFavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myFavoritesTitle: UILabel!
    @IBOutlet weak var myFavoritesPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
