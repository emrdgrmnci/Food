//
//  MyCartTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 2.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {
    
     static let reuseIdentifier = "QuoteCell"
    
    @IBOutlet weak var myCartFoodNameLabel: UILabel!
    @IBOutlet weak var myCartFoodPriceLabel: UILabel!
    
    
//    var foodItem: Food! {
//        didSet {
//            self.updateUI()
//        }
//    }
//    
//    func updateUI() {
//        myCartFoodNameLabel.text = foodItem.name.description
//        myCartFoodPriceLabel.text = foodItem.price.description
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
