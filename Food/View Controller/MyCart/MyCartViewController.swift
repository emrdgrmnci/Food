//
//  MyCartViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 2.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import CoreData

class MyCartViewController: UIViewController {
    
    var fromDetailFoodNames = ""
    var fromDetailFoodPrices = ""
    var backgroundView: UIView?
    
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var approveCart: UIButton!
    
    var food: Food?
    
    var fromSharedFood = SingletonCart.sharedFood.food
    
    let cartCell = MyCartTableViewCell()
    //TODO: - Approve my  cart
    @IBAction func approveCart(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "CheckoutViewController")
        guard viewController != nil else { return }
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .red
        resetTotalPrice()
        if fromSharedFood.count == 0 {
            self.tabBarController?.viewControllers![1].tabBarItem.badgeValue = nil
            
        }  else {
            self.tabBarController?.viewControllers![1].tabBarItem.badgeValue = "\(fromSharedFood.count)"
        }
        self.tabBarController?.tabBar.isHidden = false
        self.myCartTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        fromSharedFood = SingletonCart.sharedFood.food
        
        if fromSharedFood.count == 0 {
            
            myCartTableView.setEmptyView(title: "Sepetinizde ürün bulunmamaktadır", message: "Seçtiğiniz yemekler burada listelenir.")
            approveCart.isEnabled = false
        }
        else {
            myCartTableView.restore()
        }
        self.tabBarController?.viewControllers![1].tabBarItem.badgeValue = "\(fromSharedFood.count)"
        resetTotalPrice()
        self.myCartTableView.reloadData()
    }
    
    func resetTotalPrice() {
        var tempTotalPrice = 0 as Decimal
        for sharedFoodTotalPrice in fromSharedFood {
            tempTotalPrice += Decimal((sharedFoodTotalPrice.price * sharedFoodTotalPrice.foodQuantity))
        }
        
        totalPriceLabel.text = "Toplam: \(tempTotalPrice) ₺"
    }
}

extension MyCartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if fromSharedFood.count == 0 {
            tableView.setEmptyView(title: "Sepetinizde ürün bulunmamaktadır", message: "Seçtiğiniz yemekler burada listelenir.")
            approveCart.isEnabled = false
        }
        else {
            tableView.restore()
        }

        return fromSharedFood.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodName = fromSharedFood[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell", for: indexPath) as! MyCartTableViewCell
        cell.myCartFoodNameLabel.text = "\(foodName.productTitle) - \(foodName.foodQuantity ) adet"
        self.tabBarController?.viewControllers![1].tabBarItem.badgeValue = "\(fromSharedFood.count)"
        cell.myCartFoodPriceLabel.text = "\(foodName.price * (foodName.foodQuantity )) ₺"
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SingletonCart.sharedFood.food.remove(at: indexPath.row)
            fromSharedFood = SingletonCart.sharedFood.food
            resetTotalPrice()
            //            fromSharedFood.removeAll()
            tableView.deleteRows(at: [indexPath], with: .fade)
            //            tableView.beginUpdates()
            tableView.reloadData()

            if fromSharedFood.count == 0 {
                myCartTableView.setEmptyView(title: "Sepetinizde ürün bulunmamaktadır", message: "Seçtiğiniz yemekler burada listelenir.")

                myCartTableView.reloadData()
                self.tabBarController?.viewControllers![1].tabBarItem.badgeValue = nil
                approveCart.isEnabled = false
            }
            else {
                self.tabBarController?.viewControllers![1].tabBarItem.badgeValue = "\(fromSharedFood.count)"
                myCartTableView.restore()
            }
        }
    }
}
