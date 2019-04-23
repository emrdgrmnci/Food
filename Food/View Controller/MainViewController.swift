//
//  MainViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let foodSource: FoodsDataSource
    
    required init?(coder aDecoder: NSCoder) {
        let foods = [
            Food(name: "Whopper", price: 15.0),
            Food(name: "Big Mac", price: 20.0),
            Food(name: "Steakhouse", price: 25.0)
        ]
        let imageNames = [
            ImageNames(name: "images"),
            ImageNames(name: "unnamed-1"),
            ImageNames(name: "unnamed")
            
        ]
        self.foodSource = FoodsDataSource(foods: foods, images: imageNames)
        super.init(coder: aDecoder)
    }
    
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
        
        mainTableView.dataSource = foodSource
        mainCollectionView.dataSource = foodSource
        mainTableView.reloadData()
        mainCollectionView.reloadData()
        
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

