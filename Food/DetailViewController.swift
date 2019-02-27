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
    var selectedDrink: String?
    var selectDrink : DetailChooseDrinkTableViewCell!
    
    @IBOutlet weak var detailTableView: UITableView!    

    var prices = [FoodPrices]()
    
    var pickerDrinks = [
        "Ayran (2,5₺)",
        "2 X Ayran (5,0₺)",
        "3 X Ayran (7,5₺)",
        "Kola (4,0₺)",
        "2 X Kola (8,0₺)",
        "3 X Kola (12,0₺)",
        "Su (2,0₺)",
        "2 X Su (4,0₺)",
        "3 X Su (6,0₺)"]
    
    //TODO:- Add to basket
    @IBAction func addBasket(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prices = [FoodPrices(purchaseAmount: 15.0),FoodPrices(purchaseAmount: 25.0)]
        detailTableView.reloadData()
        createDrinkPicker()
        
        self.tabBarController?.tabBar.isHidden = true
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
        return 3
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
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "piecePriceCell", for: indexPath) as! DetailFoodPieceTableViewCell
//            cell.priceLabel?.text = "₺\(detailFoodPrice)"
            cell.foodPrice = prices[indexPath.row]
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chooseDrinkCell", for: indexPath) as! DetailChooseDrinkTableViewCell
            
            return cell
        }
        
    }
    
    func createDrinkPicker() {
        
        let drinkPicker = UIPickerView()
        drinkPicker.delegate = self
        
        selectDrink?.selectDrinkTextField?.inputView = drinkPicker
        
    }
}

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDrinks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDrinks[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedDrink = pickerDrinks[row]
        selectDrink.selectDrinkTextField.text = selectedDrink
    }
    
}


