//
//  MainViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    
    var imageNames = [ImageNames]()
    var priceFood: [Double]!
    var searchFoods = [String]()
    var filtered = [String]()
    var searching = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        let foodCell = Food(name: ["Hamburger big mac",
                                   "Patates",
                                   "Whopper",
                                   "Steakhouse"], price: [15.0, 20.0, 25.0, 30.0])
        //        mainTableView.delegate = self
        //        mainTableView.dataSource = self
        searchBar.delegate = self
        
        searchFoods = foodCell.name
        priceFood = foodCell.price
        
        imageNames = [
            ImageNames(name: "images"),
            ImageNames(name: "unnamed"),
            ImageNames(name: "unnamed")
            //            ImageNames(name: "images"),
            //            ImageNames(name: "images")
        ]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
         return self.filtered.count
        }
        return section == 0 ? 1 : self.searchFoods.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainFoodTableViewCell", for: indexPath) as! MainFoodTableViewCell
          
//            cell.mainFoodCollectionView.delegate = self
//            cell.mainFoodCollectionView.dataSource = self
//            cell.mainFoodCollectionView.reloadData()
            cell.mainFoodCollectionView.tag = indexPath.row
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood", for: indexPath) as! MainFoodTitleTableViewCell
            
            if searching {
                cell.titleLabel?.text = filtered[indexPath.row]
                cell.priceLabel?.text = priceFood[indexPath.row].description
            } else {
                cell.titleLabel?.text = searchFoods[indexPath.row]
                cell.priceLabel?.text = priceFood[indexPath.row].description
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searching && indexPath.section == 0 {
            return 0
        }
        return indexPath.section == 0 ? 130 : 65
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 65
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellForFoodSegue" {
            if let destinationViewController = segue.destination as? DetailViewController
            {
                let indexPath = self.mainTableView.indexPathForSelectedRow!
                
                var foodNames: String
                var foodPrices: Double
                
                foodNames = searchFoods[indexPath.row]
                foodPrices = priceFood[indexPath.row]
                
                destinationViewController.detailFoodName = foodNames
                destinationViewController.detailFoodPrice = foodPrices
                
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  imageNames.count
    }
    
    //MARK:- collection view cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: 130)
    }
    
    //MARK:- //collection view cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFoodCollectionViewCell", for: indexPath) as! MainFoodCollectionViewCell
        let img = imageNames[indexPath.row]
        cell.mainFoodImage.image = UIImage(named: img.name)
        return cell
    }
}

//MARK:- SearchBar data
extension MainViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
//        mainTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        mainTableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.searchFoods.filter ({$0.prefix(searchText.count) == searchText})
        searching = true
        mainTableView.reloadData()
        
    }
}

