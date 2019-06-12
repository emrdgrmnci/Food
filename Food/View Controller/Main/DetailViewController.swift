//
//  DetailViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 24.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import TagListView
import Moya
import Kingfisher
import SwiftyJSON

class DetailViewController: UIViewController, TagListViewDelegate {
    
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodSubTitle: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodQuantity: UILabel!
    @IBOutlet weak var detailFoodImage: UIImageView!
    
    @IBOutlet weak var tagListView: TagListView!
    
    var window: UIWindow?
    
    var detailFoodName = ""
    var detailFoodPrice = 0.0
    var detailPhotoData = String()
    
    var searchFoods: String!
    var priceFood: Double!
    
    var food: Food?
    var foodDetailProvider = MoyaProvider<FoodNetwork>()
    
    //    var q = 1
    //    var fp = 0
    
    //    var foodPriceCount = FoodPriceCount(foodPriceCount: ) {
    //
    //        didSet {
    //            let quantity = foodPriceCount.quantity
    //            let price = foodPriceCount.foodPrice * Double(quantity)
    //            foodQuantity.text = "\(quantity)"
    //            foodPrice.text = "\(price)"
    //
    //        }
    //    }
    //
    //    @IBAction func addQuantity(_ sender: Any) {
    //        if foodPriceCount.quantity < 30 {
    //            foodPriceCount.quantity += 1
    //        }
    //    }
    //
    //    @IBAction func decreasedQuantity(_ sender: Any) {
    //        if foodPriceCount.quantity > 0 {
    //            foodPriceCount.quantity -= 1
    //        }
    //    }
    
    //TODO:- Add to basket
    @IBAction func addBasket(_ sender: Any) {
        
        SingletonCart.sharedFood.food.append(food!)
        
        self.performSegue(withIdentifier: "toMyCart", sender: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.isLoading(true)
        //        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodQuantity.text = "1"
        
        foodTitle.text = food?.ProductTitle ?? ""
        foodPrice.text = food?.PriceString
        
        let url = URL(string: "http://tezwebservice.pryazilim.com/api/ProductService/GetAllProductList/\(self.food!.PhotoPath)")
        detailFoodImage.kf.setImage(with: url)
        
        tagListView.delegate = self
        setupIngredientsTag()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.title = "Sipariş Detayı"
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FoodOrder")
        self.window?.rootViewController = viewController
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        //        self.view.addGestureRecognizer(tapGesture)
    }
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    
    }
    @IBAction func favoriteButtonClicked(_ sender: UIBarButtonItem) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupIngredientsTag() {
        
        tagListView.textFont = UIFont.systemFont(ofSize: 14)
        tagListView.alignment = .left // possible values are .Left, .Center, and .Right

        //        tagListView.addTag("TagListView")
        
        for tags in food!.DetailsList {
            tagListView.addTags([tags])
        }
        
        //        tagListView.insertTag("This should be the second tag", at: 1)
        
        //        tagListView.setTitle("New Title", at: 6) // to replace the title a tag
        
        //        tagListView.removeTag("meow") // all tags with title “meow” will be removed
        //        tagListView.removeAllTags()
    }
    
}




