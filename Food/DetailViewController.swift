//
//  DetailViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var detailFoodName = String()
    var detailFoodPrice = Double()
    var drinkPricePicker : UIPickerView!
    var menuPiecePicker: UIPickerView!
    
    let pickerDrinks: [(name: String, price: String)] = [
        ("Ayran" , "2,5₺"),
        ("2 X Ayran" , "5,0₺"),
        ("3 X Ayran" , "7,5₺"),
        ("Kola" , "4,0₺"),
        ("2 X Kola" , "8,0₺"),
        ("3 X Kola" , "12,0₺")]
    
    
    @IBOutlet weak var detailTableView: UITableView!
    
    //TODO:- Add to basket
    @IBAction func addBasket(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.title = "Sipariş Detayı"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
            cell.priceLabel?.text = "₺\(detailFoodPrice)"
            cell.choosePiece?.
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chooseDrinkCell", for: indexPath) as! DetailChooseDrinkTableViewCell
            
            return cell
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDrinks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDrinks[row].name
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


