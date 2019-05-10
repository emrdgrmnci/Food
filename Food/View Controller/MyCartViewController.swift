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
    
    
    var food: Food?
    
    var foodInfos: [String] = ["Whopper", "Steakhouse", "Big mac"]
    var fromSharedFood = SingletonCart.sharedFood.food
    //TODO: - Approve my  cart
    @IBAction func approveCart(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myCartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fromSharedFood.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodName = fromSharedFood[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell", for: indexPath) as! MyCartTableViewCell
        cell.myCartFoodNameLabel.text = foodName.name
        cell.myCartFoodPriceLabel.text = "\(foodName.price)₺"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fromSharedFood.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
