//
//  DetailViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var detailFoodName = String()
    var detailFoodPrice = Double()
    var menuPieceStepper : UIStepper!
    var prices = [FoodPrices]()
    
    @IBOutlet weak var detailTableView: UITableView!
    
    //TODO:- Add to basket
    @IBAction func addBasket(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addToCartSegue") {
            if let addToCartVC = segue.destination as? MyCartViewController {
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        prices = [FoodPrices(purchaseAmount: 15.0),FoodPrices(purchaseAmount: 25.0)]
        detailTableView.reloadData()
        
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.title = "Sipariş Detayı"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodNameCell", for: indexPath) as! DetailFoodTableViewCell
            cell.detailFoodNameLabel?.text = detailFoodName
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "piecePriceCell", for: indexPath) as! DetailFoodPieceTableViewCell
            cell.priceLabel?.text = "\(detailFoodPrice)₺"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



