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
    
    
    let foods = Food(name: ["Hamburger big mac",
                               "Patates",
                               "Whopper",
                               "Steakhouse"], price: [15.0, 20.0, 25.0, 30.0])
    let food: Food! = nil

    var foodPriceCount = FoodPriceCount(quantity: 1, foodPrice: 15.0) {
        
        didSet {
            foodQuantity.text = "\(foodPriceCount.quantity)"
            foodPrice.text = "\(Double(foodPriceCount.quantity) * foodPriceCount.foodPrice)TL"
            
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

            let destinationVC = MyCartViewController()
        
            destinationVC.fromDetailFoodNames = foods.name
            destinationVC.fromDetailFoodPrices = foods.price
        
//            delegate?.foodCell(destinationVC)
//            self.navigationController?.popViewController(animated: true)
        dismiss(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "addToCartSegue") {
            if let addToCartVC = segue.destination as? MyCartViewController {
                
                addToCartVC.fromDetailFoodNames = [foodTitle.text]
                addToCartVC.fromDetailFoodPrices = foods.price

        }
       }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodQuantity.text = "1"
        
        drinkPickerView.delegate = self
        drinkPicker.inputView = drinkPickerView
        selectDrinkType = ["Ayran", "Kola", "Su", "Fanta", "Şalgam", "Sprite"]
        
        foodTitle.text = detailFoodName
        foodPrice.text = String(detailFoodPrice)
        
        
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.title = "Sipariş Detayı"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
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



