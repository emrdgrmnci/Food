//
//  MainViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let foodSource: FoodsDataSource
    
    required init?(coder aDecoder: NSCoder) {
        let foods = [
            Food(category: "Kahvaltı", name: "Hafta İçi Kahvaltısı", price: 18.0),
            Food(category: "Kahvaltı", name: "Pazar Kahvaltısı", price: 25.0),
            Food(category: "Kahvaltı", name: "Diyet Kahvaltı", price: 22.0),
            Food(category: "Kahvaltı", name: "Köy Kahvaltısı", price: 15.0),
            Food(category: "Kahvaltı", name: "Ege Kahvaltısı", price: 30.0)
        ]
        let burgers = [ Food(category: "Hamburger", name: "Big TezzBurger", price: 26.0),
                        Food(category: "Hamburger", name: "TezzRoyal", price: 24.0),
                        Food(category: "Hamburger", name: "Double TezzBurger", price: 17.0),
                        Food(category: "Hamburger", name: "TezzChicken", price: 21.0),
                        Food(category: "Hamburger", name: "Köfteburger", price: 28.0) ]
        let drinks = [
            Food(category: "İçecek", name: "Kola", price: 4.0),
            Food(category: "İçecek", name: "Fanta", price: 4.0),
            Food(category: "İçecek", name: "Gazoz", price: 4.0),
            Food(category: "İçecek", name: "Soğuk Çay", price: 4.0),
            Food(category: "İçecek", name: "Ayran", price: 4.0) ]
        let desserts = [
            Food(category: "Tatlı", name: "Tezzdae", price: 6.0),
            Food(category: "Tatlı", name: "Tezz Cake", price: 8.0),
            Food(category: "Tatlı", name: "Tezz Flurry", price: 17.0),
            Food(category: "Tatlı", name: "Dondurma", price: 8.0),
            Food(category: "Tatlı", name: "Sütlaç", price: 12.0) ]
        
        let imageNames = [
            ImageNames(name: "images"),
            ImageNames(name: "unnamed-1"),
            ImageNames(name: "unnamed")
            
        ]
        self.foodSource = FoodsDataSource(foods: foods, images: imageNames)
        super.init(coder: aDecoder)
    }
    
    //    var searchFoods = [String]()
    //    var filtered = [String]()
    //    var searching = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        mainTableView.dataSource = foodSource
        mainCollectionView.dataSource = foodSource
        mainTableView.reloadData()
        mainCollectionView.reloadData()
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    }
    
    
    @objc fileprivate func handleSegmentChange() {
        print(segmentedControl.selectedSegmentIndex)
        let foodSC = foodSource.foods
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            foodSC.index(before: 4)
            
        case 1:
            foodSC.index(before: 8)
            
        case 2:
            foodSC.index(before: 12)
            
        case 3:
            foodSC.index(before: 16)
            
        default:
            fatalError("Not selected any segment!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellForFood" {
            if let indexPath = self.mainTableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                let foods = foodSource.foods
                controller.food = foods[indexPath.row]
            }
        }
        
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

