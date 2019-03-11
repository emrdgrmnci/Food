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
    
    var foodInfos = (Food(name: ["Deneme"], price: [10.0]))
//    {
//        didSet {
//            myCartTableView.reloadData()
//        }
//    }
    

    
    //TODO-: Delete my cart
//    @IBAction func deleteMyCart(_ sender: Any) {
//        if !foodInfos.isEmpty {
//            foodInfos.removeLast()
//            myCartTableView.reloadData()
//        }
//    }
    
    //TODO: - Approve my  cart
    @IBAction func approveCart(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : foodInfos.name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell", for: indexPath) as! MyCartTableViewCell
        
        
        //&& indexPath.last! <= fromDetailFoodPrices.indices.last!
        if indexPath.section == 1 {
         cell.myCartFoodNameLabel.text = fromDetailFoodNames
         cell.myCartFoodPriceLabel.text = fromDetailFoodPrices
//        let name = fromDetailFoodNames[indexPath.row]?.description ?? ""
//        let price = fromDetailFoodPrices[indexPath.row]
//        cell.myCartFoodNameLabel?.text = infos.name.description
//        cell.myCartFoodPriceLabel?.text = "\(String(describing: infos.price))₺"
        
        }
        return cell
    }
}
