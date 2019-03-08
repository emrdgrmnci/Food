//
//  MyCartViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 2.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fromDetailFoodNames: [String?] = []
    var fromDetailFoodPrices: [Double?] = []
    
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var foodInfos: [Food] = []
//    {
//        didSet {
//            myCartTableView.reloadData()
//        }
//    }
    
    let foodNames = [
        "Hamburger big mac",
        "Patates",
        "Whopper",
        "Steakhouse"
    ]
    
    //TODO-: Delete my cart
    @IBAction func deleteMyCart(_ sender: Any) {
        if !foodInfos.isEmpty {
            foodInfos.removeLast()
        }
    }
    
    //TODO: - Approve my  cart
    @IBAction func approveCart(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1 : foodNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell", for: indexPath) as! MyCartTableViewCell
        
        
        //&& indexPath.last! <= fromDetailFoodPrices.indices.last!
        if indexPath.section == 1 {
         cell.foodItem = foodInfos[indexPath.row]
//        let name = fromDetailFoodNames[indexPath.row]?.description ?? ""
//        let price = fromDetailFoodPrices[indexPath.row]
//        cell.myCartFoodNameLabel?.text = infos.name.description
//        cell.myCartFoodPriceLabel?.text = "\(String(describing: infos.price))₺"
        
        }
        return cell
    }
}
