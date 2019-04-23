//
//  MyCartViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 2.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fromDetailFoodNames = ""
    var fromDetailFoodPrices = ""
    
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    
       var foodInfos: [String] = ["Whopper", "Steakhouse", "Big mac"]

    //TODO: - Approve my  cart
    @IBAction func approveCart(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        fromDetailFoodNames = foodInfos.name.description
//        fromDetailFoodPrices = foodInfos.price.description
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let foodName = foodInfos[indexPath.row]
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell", for: indexPath) as! MyCartTableViewCell
         cell.myCartFoodNameLabel.text = foodName
        //        let myCartFoodList = SingletonCart.sharedFood.food[indexPath.row]
//        cell.myCartFoodNameLabel?.text = myCartFoodList.
        
        //&& indexPath.last! <= fromDetailFoodPrices.indices.last!
        
//         cell.myCartFoodNameLabel.text = fromDetailFoodNames
//         cell.myCartFoodPriceLabel.text = fromDetailFoodPrices
//        let name = fromDetailFoodNames[indexPath.row]?.description ?? ""
//        let price = fromDetailFoodPrices[indexPath.row]
//        cell.myCartFoodNameLabel?.text = infos.name.description
//        cell.myCartFoodPriceLabel?.text = "\(String(describing: infos.price))₺"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foodInfos.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
