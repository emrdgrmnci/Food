//
//  DetailViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodSubTitle: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodQuantity: UILabel!
    @IBOutlet weak var detailFoodImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!

    var window: UIWindow?
    var detailFoodName = ""
    var detailFoodPrice = 0.0
    var detailPhotoData = String()
    var searchFoods: String!
    var priceFood: Double!
    var food: Food?
//    var favoriteData = [FavoriteList]()
    var isFirstClick = false
    var tempQuantity = 1

    var foodPriceAccumulate = FoodPriceCount(quantity: 1, foodPrice: 10) {
        willSet {
            self.foodPriceAccumulate.quantity = 1
            self.foodPriceAccumulate.foodPrice = food!.price
        }
        didSet {
            let quantity = foodPriceAccumulate.quantity
            let price = food!.price * quantity
            foodQuantity.text = "\(String( describing: quantity))"
            foodPrice.text = "\(price) ₺"
            SingletonCart.sharedFood.food.append(food!)
        }
    }
    @IBAction func addQuantity(_ sender: Any) {
        if foodPriceAccumulate.quantity < 30 {
            tempQuantity += 1
            foodPriceAccumulate.quantity += 1
        }
    }
    @IBAction func decreasedQuantity(_ sender: Any) {
        if foodPriceAccumulate.quantity > 0 {
            tempQuantity -= 1
            foodPriceAccumulate.quantity -= 1
        }
    }
    //TODO:- Add to basket
    @IBAction func addToBasket(_ sender: Any) {
        food?.foodQuantity = Double(tempQuantity)
        SingletonCart.sharedFood.food.append(food!)

        self.performSegue(withIdentifier: "toMyCart", sender: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.isLoading(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .red
        foodQuantity.text = "1"
        foodTitle.text = food?.productTitle ?? ""
        foodPrice.text = food?.priceString
        foodSubTitle.text = food?.foodDescription

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.title = "Sipariş Detayı"

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FoodOrder")
        self.window?.rootViewController = viewController
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false

     }

     override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = true
     }

    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)

    }

    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
//        self.isLoading(true)
//        postFavoriteFood.request(.postCreateFavorite(food!.id)) {
//            [weak self] result in
//            guard self != nil else { return }
//            let statusCode = result.value?.statusCode
//            switch result {
//            case .success(let response):
//                switch statusCode {
//                case 200:
//                    self!.isLoading(false)
//                    do {
//                        let data = response.data
//                        let json = try JSON(data: data)
//                        let favoriteResponse = try JSONDecoder().decode(FavoriteListServiceResponse.self, from: response.data)
//
//                        if (favoriteResponse.Success) {
//                            //MARK: Favorite button state
//                            self!.favoriteButton.image = UIImage(named: "liked")
//                            print(json.debugDescription)
//                        } else {
//
//                            self?.showAlert(withTitle: "Hata", withMessage: favoriteResponse.Message!, withAction: "pop")
//
//                            //MARK: Favorite button state
//                            //                                        self!.favoriteButton.image = UIImage(named: "like")
//                            //                                        UserDefaults.standard.set(false, forKey: "favorited")
//                            //                                        self!.isFirstClick = false
//                        }
//                    } catch {
//                        print("favorite error")
//                    } default :
//                        self!.isLoading(false)
//                    break //Error handler
//                }
//            case .failure(let error):
//                self!.isLoading(false)
//                self!.showError(error.response!)
//                self?.showAlert(withTitle: "Hata", withMessage: "Bu ürün favoriye eklenemez!", withAction: "pop")
//                if let code = error.response?.statusCode {
//                    if code == 401 {
//                        self?.showAlert(withTitle: "Hata", withMessage: "Bu ürün favoriye eklenemez!", withAction: "pop")
//                    }
//                }
//            }
//        }
//
    }
//    func getFavoritedFunc() {
//        getFavoriteFood.request(.getFavoriteList) { [weak self] result in
//            guard self != nil else {return}
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    do {
//
//                        let data = response.data
//                        _ = try JSON(data: data)
//
//                        let favoriteResponse = try! JSONDecoder().decode(FavoriteListServiceResponse.self, from: response.data)
//                        self!.favoriteData = favoriteResponse.ResultList!
//                    } catch {
//                        print("Error info: \(error)")
//                    }
//                }
//            case .failure(let error):
//                print(error.response!)
//            }
//
//        }
//    }
    //IsFavoriteServiceResponse
    func isFavoritedFunc() {
//        isFavoriteProvider.request(.isFavorite(food!.id)) { [weak self] result in
//            guard self != nil else {return}
//            switch result {
//            case .success(let response):
//                do {
//
//                    let data = response.data
//                    _ = try JSON(data: data)
//
//                    let isFavoriteResponse = try? JSONDecoder().decode(IsFavoriteServiceResponse.self, from: response.data)
//                    self!.isFirstClick = (isFavoriteResponse?.ResultObj!)!
//                    print(self!.isFirstClick)
//
//                    if self!.isFirstClick == true {
//                        self!.favoriteButton.image = UIImage(named: "liked")
//                    }else{
//                        self!.favoriteButton.image = UIImage(named: "like")
//                    }
//
//                } catch {
//                    print("Error info: \(error)")
//                }
//            case .failure(let error):
//                print(error.response!)
//            }
//
//        }
    }
}




