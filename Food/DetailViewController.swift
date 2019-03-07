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
    @IBOutlet weak var foodPiece: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var drinkPicker: UITextField!
    @IBOutlet weak var menuPieceStepper: UIStepper!
//    var menuPieceStepper : UIStepper!
    var drinkPickerView = UIPickerView()
    
    var selectDrinkType: [String] = []
    var detailFoodName : [String] = []
    var detailFoodPrice : [Double] = [0.0]
    
    
    
    let foods = Food(name: ["Hamburger big mac",
                               "Patates",
                               "Whopper",
                               "Steakhouse"], price: [15.0, 20.0, 25.0, 30.0])

    
    @IBAction func foodPieceStepper(_ sender: Any) {
    }
    
    @objc func foodPieceChangeStepper() {
        let res = menuPieceStepper.value + foods.price.first!
        foodPrice.text = "\(res)"
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
                
                
//                let selectedCell = sender as! UITableViewCell
//                let indexPath = self.detailTableView.indexPath(for: selectedCell)

//                var foodName: [String]
//                var foodPrice: [Double]
//
//                foodName = foodNames
//                foodPrice = foodPrices
//
//                addToCartVC.fromDetailFoodNames = foodName
//                addToCartVC.fromDetailFoodPrices = foodPrice

        }
       }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPieceStepper.value = 0.0
        menuPieceStepper.minimumValue = 0.0
        menuPieceStepper.maximumValue = 30.0
        menuPieceStepper.stepValue = foods.price.first!
        menuPieceStepper.addTarget(self, action: #selector(foodPieceChangeStepper), for: .valueChanged)
        
        drinkPickerView.delegate = self
        drinkPicker.inputView = drinkPickerView
        selectDrinkType = ["Ayran", "Kola", "Su", "Fanta", "Şalgam", "Sprite"]
        
        foodTitle.text = detailFoodName.description
        foodPrice.text = detailFoodPrice.description
        
        
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



