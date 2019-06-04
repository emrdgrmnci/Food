//
//  MainFoodTitleTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MainFoodTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    //    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBAction func foodAdd(_ sender: Any) {
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title ?? ""
        }
    }
    
    var price: Int? {
        didSet {
            priceLabel.text = "\(price ?? 0)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
