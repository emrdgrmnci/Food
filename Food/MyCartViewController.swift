//
//  MyCartViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 2.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fromDetailFoodName = String()
    var fromDetailFoodPrice = Double()
    

    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let foodNames = [
        "Hamburger big mac",
        "Cemal",
        "Emre",
        "Memo"
    ]
    
    //TODO-: Delete my cart
    @IBAction func deleteMyCart(_ sender: Any) {
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
        cell.myCartFoodNameLabel?.text = fromDetailFoodName
        cell.myCartFoodPriceLabel?.text = "\(fromDetailFoodPrice)₺"
        return cell
    }


}
