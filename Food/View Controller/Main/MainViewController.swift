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
    
    //MARK: Menu Categories
    var sections = [String]()
    
    var foodProvider = MoyaProvider<FoodNetwork>()
    var sliderProvider = MoyaProvider<SliderNetwork>()
    
    var sliderData = [String]()
    var foodData = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.object(forKey: "userID") as? Int ?? 0)
        self.navigationController?.navigationBar.isHidden = false
        
                        getFoodFunc()
        
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
                        var count = 0
                        var isHere = false
                        for sectionItem in foodResponse.ResultList! {
                            for i in 0...(count == 0 ? 0 : count-1) {
                                if self?.sections != nil{
                                    if sectionItem.SubCategoryTitle == self?.sections[i]{
                                    isHere = true
                                    break
                                }
                                }
                            }
                            if isHere == false{
                                 self?.sections.append(sectionItem.SubCategoryTitle)
                                 count+1
                            }
                        }
                        
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
                                    //                            self!.sliderData.append("http://mehmetguner.pryazilim.com/UploadFile/Slider\(resultList.PhotoPath)")
                                    self!.sliderData.append(resultList.PhotoPath)//TODO: Mehmete publish yap deyince bunu üst satırla değiştir
                                    print(resultList.PhotoPath)
                                }
                                self!.mainCollectionView.reloadData()
                                
                                isResult=sliderResponse.Success
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
            
            
            //MARK: Segue from MainVC to DetailVC
            
            //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //        if segue.identifier == "cellForFood" {
            //            if let indexPath = self.mainTableView.indexPathForSelectedRow {
            //                let controller = segue.destination as! DetailViewController
            //                let foods = foodSource.foods
            //                controller.food = foods[indexPath.row]
            //            }
            //        }
            //
            //    }
            
            
        }
        
        extension MainViewController: UITableViewDataSource, UITableViewDelegate {
            
            
            func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return sections[section]
            }
            
            func numberOfSections(in tableView: UITableView) -> Int {
                return sections.count
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return foodData.count
            }
            
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood") as! MainFoodTitleTableViewCell
                let foodList = foodData[indexPath.row]
                //        let food = foods.filter({$0.category == sections[indexPath.section]})[indexPath.row]
                cell.titleLabel.text = foodList.ProductTitle
                cell.priceLabel.text = foodList.PriceString
                
                return cell
            }
        }

    
    extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return sliderData.count
        }
        
        //MARK:- collection view cell size
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = UIScreen.main.bounds.width
            return CGSize(width: width, height: 130)
        }
        
        //MARK:- //collection view cell data
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFoodCollectionViewCell", for: indexPath) as! MainFoodCollectionViewCell
            
            let url = URL(string: self.sliderData[indexPath.row])
            cell.mainFoodImage.kf.setImage(with: url)
            //        let img = self.sliderData[indexPath.row]
            //        cell.mainFoodImage.image = UIImage(named: img)
            return cell
        }
        
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}

//MARK:- SearchBar data
//extension MainViewController : UISearchBarDelegate {
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//
//        self.searchBar.showsCancelButton = true
//        //        mainTableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchBar.showsCancelButton = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//        mainTableView.reloadData()
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filtered = self.searchFoods.filter ({$0.prefix(searchText.count) == searchText})
//        searching = true
//        mainTableView.reloadData()
//
//    }
//}


