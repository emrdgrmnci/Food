//
//  DetailFoodPieceTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class DetailFoodPieceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuPieceStepper: UIStepper!
    @IBOutlet weak var constantPieceLabel: UILabel!
    
    var foodPrice : FoodPrices! {
        didSet {
            
            menuPieceStepper.value = foodPrice.purchaseAmount
            priceLabel.text = String(foodPrice.purchaseAmount)
            
        }
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        
        foodPrice?.purchaseAmount = sender.value
        self.priceLabel.text = String(sender.value)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
