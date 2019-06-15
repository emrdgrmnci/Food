//
//  MainViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import Kingfisher
import SwiftyJSON

class MainViewController: UIViewController {
    
    //    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var sliderProvider = MoyaProvider<SliderNetwork>()
    var foodProvider = MoyaProvider<FoodNetwork>()
    var foodCategoryProvider = MoyaProvider<FoodCategoryNetwork>()
    let userInfoProvider = MoyaProvider<GetInfoNetwork>()
    
    var sliderData = [String]()
    var foodData = [Food]()
    var foodCategoryData = [FoodCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User ID: \(UserDefaults.standard.object(forKey: "userID") as? Int ?? 0)")
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        getInfoFunc()
        getFoodFunc()
        getFoodCategoryFunc()
        
        let isSliderSuccess = getSliderFunc()
        //
        if isSliderSuccess {
            //
            mainCollectionView.delegate = self
            mainCollectionView.dataSource = self
            mainCollectionView.reloadData()
        }
        
        mainTableView.delegate = self
        
        mainTableView.dataSource = self
        
        mainTableView.reloadData()
        
        
        //        webServiceSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func getInfoFunc() {
        userInfoProvider.request(.getInfo) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        print(try response.mapJSON())
                        
                        let userResponse = try JSONDecoder().decode(UserInfoServiceResponse.self, from: response.data)
                        //                        detail = userResponse
                        
                        debugPrint(userResponse)
                        //                        debugPrint("Mehmet \(userResponse.ResultList![0].N )" )
                        //                        debugPrint("Mehmet \(userResponse.ResultList![0].S )" )
                        self!.navigationItem.title = ("Hoşgeldin \(userResponse.ResultObj?.N ?? "TezzFood")")
                    } catch {
                        print("Error info: \(error)")
                    }
                }
            case .failure(let error):
                self!.isLoading(false)
                print(error.response!)
            }
            
        }
    }
    
    func getFoodFunc() {
        foodProvider.request(.food) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        
                        let data = response.data
                        _ = try JSON(data: data)
                        
                        let foodResponse = try! JSONDecoder().decode(FoodServiceResponse.self, from: response.data)
                        self!.foodData = foodResponse.ResultList!
                        self!.mainTableView.reloadData()
                    } catch {
                        print("Error info: \(error)")
                    }
                }
            case .failure(let error):
                print(error.response!)
            }
            
        }
    }
    
    func getFoodCategoryFunc() {
        foodCategoryProvider.request(.foodCategory) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        
                        let data = response.data
                        _ = try JSON(data: data)
                        
                        let foodCategoryResponse = try! JSONDecoder().decode(FoodCategoryServiceResponse.self, from: response.data)
                        self!.foodCategoryData = foodCategoryResponse.ResultList!
                        self!.mainTableView.reloadData()
                    } catch {
                        print("Error info: \(error)")
                    }
                }
            case .failure(let error):
                print(error.response!)
            }
            
        }
    }
    
    func getSliderFunc() -> Bool {
        var isResult = false
        sliderProvider.request(.slider) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        
                        let data = response.data
                        _ = try JSON(data: data)
                        let sliderResponse = try JSONDecoder().decode(SliderServiceResponse.self, from: response.data)
                        
                        for resultList in sliderResponse.ResultList! {
                            self!.sliderData.append("http://mehmetguner.pryazilim.com/UploadFile/Slider/\(resultList.PhotoPath)")
                            //                            self!.sliderData.append(resultList.PhotoPath)//TODO: Mehmete publish yap deyince bunu üst satırla değiştir
                            print(resultList.PhotoPath)
                        }
                        self!.mainCollectionView.reloadData()
                        
                        isResult = sliderResponse.Success
                    } catch {
                        print("Error info: \(error)")
                    }
                }
            case .failure(let error):
                self!.isLoading(false)
                print(error.response!)
            }
            
        }
        return isResult
    }
    
    var foodSection = 0
    var foodRow = 0
    
    //    MARK: Segue from MainVC to DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedFoodToDetail" {
//            if let indexPath = self.mainTableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
//                let foods = foodData
                controller.food = foodCategoryData[foodSection].ProductList[foodRow]
            }
        }
        
//    }
}
//var seledted : Food

//func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//    if (segue.identifier == "toDetail") {
//        // initialize new view controller and cast it as your view controller
//        var viewController = segue.destination as! DetailViewController
//        // your new view controller should have property that will store passed value
//        viewController.detailFoodName =
//    }
//}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        foodSection = indexPath.section
        foodRow = indexPath.row
        
        performSegue(withIdentifier: "selectedFoodToDetail", sender: self)

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return foodCategoryData[section].SubCategoryTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodCategoryData.count
    }
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let selectedFood = foodData[indexPath.row]
    //        performSegue(withIdentifier: "toDetail", sender: self)
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // return foodData.count
        return foodCategoryData[section].ProductList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood") as! MainFoodTitleTableViewCell
        
        let category = foodCategoryData[indexPath.section]
        let food = category.ProductList[indexPath.row]
        
        cell.titleLabel.text = food.ProductTitle
        cell.priceLabel.text = food.PriceString
        
        return cell
    }
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sliderData.count
    }
    
    //MARK:- collection view cell size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    //MARK:- //collection view cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFoodCollectionViewCell", for: indexPath) as! MainFoodCollectionViewCell
        
        let url = URL(string: self.sliderData[indexPath.row])
        cell.mainFoodImage.kf.setImage(with: url)
        //        let img = self.sliderData[indexPath.row]
        //        cell.mainFoodImage.image = UIImage(named: img)
        cell.layoutIfNeeded()
        return cell
    }
    
}


