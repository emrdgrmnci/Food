//
//  FoodsDataSource.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 22.04.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class FoodsDataSource: NSObject {
    let foods: [Food]
    let imageNames: [ImageNames]
    
    init(foods: [Food], images: [ImageNames]) {
        self.foods = foods
        self.imageNames = images
    }
}
extension FoodsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
        return "Kahvaltı"
        } else if section == 1 {
        return "Hamburger"
        } else if section == 2 {
            return "İçecek"
        } else if section == 3 {
            return "Tatlı"
        }
        return "Salata"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return foods.count
    }
        return 5
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood") as! MainFoodTitleTableViewCell
        let food = foods[indexPath.row]
        cell.title = food.name
        cell.price = food.price 
        return cell
    }
    
}

extension FoodsDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
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
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return ["Promosyonlar"]
    }
    
    
}


