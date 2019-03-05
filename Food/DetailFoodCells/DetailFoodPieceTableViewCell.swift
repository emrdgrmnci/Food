//
//  DetailFoodPieceTableViewCell.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

protocol DetailFoodPieceTableViewCellDelegate: class {
    func detailFoodPriceTableViewCellDidTapStepper(_ sender: DetailFoodPieceTableViewCell)
}

class DetailFoodPieceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuPieceStepper: UIStepper!
    @IBOutlet weak var constantPieceLabel: UILabel!
    var food: Food!
    weak var delegate: DetailFoodPieceTableViewCellDelegate?
    
    var piece = 0
    
    var foodPrice : Food! {
        didSet {
            
            menuPieceStepper.value = foodPrice.price.first!
            
            //            priceLabel.text = String(foodPrice.purchaseAmount)
            
        }
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {

        delegate?.detailFoodPriceTableViewCellDidTapStepper(self)
        
        //TODO:- Set stepper 
        self.priceLabel.text = food?.price.description
//        foodPrice?.purchaseAmount = [sender.value]
//        self.priceLabel.text = Double(sender.value).description
//        self.constantPieceLabel.text = Int(piece + 1).description
//        menuPieceStepper.stepValue = 15.0
        
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
