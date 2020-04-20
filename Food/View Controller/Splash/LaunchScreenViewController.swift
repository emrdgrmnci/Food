//
//  LaunchScreenViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 9.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    var window: UIWindow!
    
    //    @IBOutlet var animationView: AnimationView!
    
    let tezzFoodLabel: UILabel = {
        let tezzLabel = UILabel()
        tezzLabel.textColor = .white
        tezzLabel.text = "TezzFood"
        tezzLabel.font = UIFont(name: "American Typewriter", size: 32)
        tezzLabel.translatesAutoresizingMaskIntoConstraints = false
        return tezzLabel
    }()
    /*
     Hamburger", foods : [
     Food(name: "Big TezBurger", price: 26.0),
     Food(name: "TezRoyal", price: 24.0),
     Food(name: "Double TezzBurger", price: 17.0),
     Food(name: "TezChicken", price: 21.0),
     Food(name: "Köfteburger", price: 28.0)]
     */

    /*
     let categories = [
     Category(name: "Breakfast", foods : [
     Food(name: "Hafta İçi Kahvaltısı", price: 18.0),
     Food(name: "Pazar Kahvaltısı", price: 25.0),
     Food(name: "Diyet Kahvaltı", price: 22.0),
     Food(name: "Köy Kahvaltısı", price: 15.0),
     Food(name: "Ege Kahvaltısı", price: 30.0)]),
     Category(name: "Hamburger", foods : [
     Food(name: "Big TezBurger", price: 26.0),
     Food(name: "TezRoyal", price: 24.0),
     Food(name: "Double TezzBurger", price: 17.0),
     Food(name: "TezChicken", price: 21.0),
     Food(name: "Köfteburger", price: 28.0)])
     ]
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //        let realm = try! Realm()
        //        print(Realm.Configuration.defaultConfiguration.fileURL)
        //        //        MARK: - Realm Code
        //        let categoryDB = Category()
        //        categoryDB.name = "Tatlılar"
        //
        //        let food1 = Food()
        //        food1.id = 11
        //        food1.price = 15.0
        //        food1.priceString = "15.0₺"
        //        food1.productTitle = "Kemalpaşa Tatlısı"
        //        food1.foodDescription = "Kemalpaşa Tatlısı"
        //        food1.stock = 10
        //        food1.foodQuantity = 10.0
        //
        //        let food2 = Food()
        //        food2.id = 12
        //        food2.price = 10.0
        //        food2.priceString = "10.0₺"
        //        food2.productTitle = "Şambali"
        //        food2.foodDescription = "Şambali"
        //        food2.stock = 10
        //        food2.foodQuantity = 10.0
        //
        //        let food3 = Food()
        //             food3.id = 13
        //             food3.price = 12.0
        //             food3.priceString = "12.0₺"
        //             food3.productTitle = "Supangle"
        //             food3.foodDescription = "Supangle"
        //             food3.stock = 10
        //             food3.foodQuantity = 10.0
        //
        //        let food4 = Food()
        //             food4.id = 14
        //             food4.price = 20.0
        //             food4.priceString = "20.0₺"
        //             food4.productTitle = "Tiramisu"
        //             food4.foodDescription = "Tiramisu"
        //             food4.stock = 10
        //             food4.foodQuantity = 10.0
        //
        //        let food5 = Food()
        //             food5.id = 15
        //             food5.price = 13.0
        //             food5.priceString = "13.0₺"
        //             food5.productTitle = "Baklava"
        //             food5.foodDescription = "Baklava"
        //             food5.stock = 10
        //             food5.foodQuantity = 10.0
        //
        //        categoryDB.foods.append(objectsIn: [food1 , food2, food3, food4, food5])
        //
        //        try! realm.write {
        //            realm.add(categoryDB)
        //        }

        //        foodDB.id = 1
        //        foodDB.price = 10.0
        //        foodDB.priceString = "10.0₺"
        //        foodDB.productTitle = "Köy Kahvaltısı"
        //        foodDB.foodDescription = "Yumurta, Peynir, Zeytin, Domates"
        //        foodDB.stock = 10
        //        foodDB.foodQuantity = 10.0

        //categoryDB.name = "Kahvaltılar"
        //        foodDB.foods[0].id = 1
        //        foodDB.foods[0].price = 10.0
        //        foodDB.foods[0].priceString = "10.0₺"
        //        foodDB.foods[0].productTitle = "Köy Kahvaltısı"
        //        foodDB.foods[0].foodDescription = "Yumurta, Peynir, Zeytin, Domates"
        //        foodDB.foods[0].stock = 10
        //        foodDB.foods[0].foodQuantity = 10.0

        //        foodDB.name = "Kahvaltılar"
        //        foodDB.foods[0].id = 2
        //        foodDB.foods[0].price = 13.0
        //        foodDB.foods[0].priceString = "13.0₺"
        //        foodDB.foods[0].productTitle = "Sahanda Yumurta"
        //        foodDB.foods[0].foodDescription = "Yumurta, Peynir"
        //        foodDB.foods[0].stock = 10
        //        foodDB.foods[0].foodQuantity = 10.0
        //
        ////        categoryDB.name = "Kahvaltılar"
        //        categoryDB.foods[2].id = 3
        //        categoryDB.foods[2].price = 15.0
        //        categoryDB.foods[2].priceString = "15.0₺"
        //        categoryDB.foods[2].productTitle = "Serpme Kahvaltı"
        //        categoryDB.foods[2].foodDescription = "Yumurta, Peynir, Bal, Reçel, Tereyağı"
        //        categoryDB.foods[2].stock = 10
        //        categoryDB.foods[2].foodQuantity = 10.0
        //
        ////        categoryDB.name = "Kahvaltılar"
        //        categoryDB.foods[3].id = 4
        //        categoryDB.foods[3].price = 14.0
        //        categoryDB.foods[3].priceString = "14.0₺"
        //        categoryDB.foods[3].productTitle = "Menemen"
        //        categoryDB.foods[3].foodDescription = "Yumurta, Peynir, Biber"
        //        categoryDB.foods[3].stock = 10
        //        categoryDB.foods[3].foodQuantity = 10.0
        //
        ////        categoryDB.name = "Kahvaltılar"
        //        categoryDB.foods[4].id = 5
        //        categoryDB.foods[4].price = 18.0
        //        categoryDB.foods[4].priceString = "18.0₺"
        //        categoryDB.foods[4].productTitle = "Haftaiçi Kahvaltısı"
        //        categoryDB.foods[4].foodDescription = "Yumurta, Peynir, Biber, Domates, Bal, Çay"
        //        categoryDB.foods[4].stock = 10
        //        categoryDB.foods[4].foodQuantity = 10.0

        //                try! realm.write {
        //                    realm.add(categoryDB)
        //                }


        //MARK: - Delete Realm
        //        let items = [Food]() // fill in your items values
        //
        //                let results = realm.objects(Food.self)
        //        //        let items = realm.objects(Food.self)
        //                try! realm.write {
        //                    realm.delete(results)
        //                }

        startAnimation()
        
        setupLayout()

        //MARK: Splash screen animation time delay
        perform(#selector(LaunchScreenViewController.showMainScreen), with: nil, afterDelay: 1.5)
    }
    
    func startAnimation() {
        let animationView = AnimationView(name: "5326-loading-10-cooker", bundle: Bundle(path: Bundle.main.path(forResource: "Animations", ofType: "bundle")!)!)
        animationView.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 250, height: 250)
        animationView.center = self.view.center
        self.view.addSubview(animationView)
        animationView.play()
    }
    
    private func setupLayout() {
        
        self.view.addSubview(tezzFoodLabel)
        
        //        tezzFoodLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        tezzFoodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tezzFoodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        //        tezzFoodLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tezzFoodLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        //        tezzFoodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        //        tezzFoodLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 105).isActive = true
        //        tezzFoodLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        //        tezzFoodLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -310).isActive = true
    }
    
    
    @objc func showMainScreen() {
        performSegue(withIdentifier: "showMainScreenSegue", sender: self)
    }
    
}
