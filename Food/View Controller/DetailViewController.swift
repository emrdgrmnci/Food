//
//  DetailViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodSubTitle: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var drinkPicker: UITextField!
    @IBOutlet weak var foodQuantity: UILabel!
    
    
    var drinkPickerView = UIPickerView()
    var selectDrinkType: [String] = []
    var detailFoodName = ""
    var detailFoodPrice = 0.0
    
    var searchFoods: String!
    var priceFood: Double!
    
    //    let foods = Food(name: ["Hamburger big mac",
    //                               "Patates",
    //                               "Whopper",
    //                               "Steakhouse"], price: [15.0, 20.0, 25.0, 30.0])
    var food: Food?
    
    var foodPriceCount = FoodPriceCount(quantity: 1, foodPrice: 15.0) {
        
        didSet {
            let quantity = foodPriceCount.quantity
            let price = foodPriceCount.foodPrice * Double(quantity)
            foodQuantity.text = "\(quantity)"
            foodPrice.text = "\(price)"
            
        }
    }
    
    @IBAction func addQuantity(_ sender: Any) {
        if foodPriceCount.quantity < 30 {
            foodPriceCount.quantity += 1
        }
    }
    
    @IBAction func decreasedQuantity(_ sender: Any) {
        if foodPriceCount.quantity > 0 {
            foodPriceCount.quantity -= 1
        }
    }
    
    //TODO:- Add to basket
    @IBAction func addBasket(_ sender: Any) {
        
        
        
        SingletonCart.sharedFood.food.append(food!)
        
        
        //            destinationVC.fromDetailFoodNames = food.name
        //            destinationVC.fromDetailFoodPrices = food.price.description
        
        //            delegate?.foodCell(destinationVC)
        //            self.navigationController?.popViewController(animated: true)
        dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodQuantity.text = "1"
        
        drinkPickerView.delegate = self
        drinkPicker.inputView = drinkPickerView
        selectDrinkType = ["Ayran", "Kola", "Su", "Fanta", "Şalgam", "Sprite"]
        
        //        searchFoods = food.name
        //        priceFood = food.price
        
        foodTitle.text = food?.name ?? ""
        foodPrice.text = "\(food?.price ?? 0.0)TL"
        
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.title = "Sipariş Detayı"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        drinkPicker.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectDrinkType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectDrinkType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedDrink = selectDrinkType[row]
        drinkPicker.text = selectedDrink
    }
    
    
}



