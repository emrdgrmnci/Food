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
//MARK: Menu Categories
let sections = ["Kahvaltı", "Hamburger", "İçecek", "Tatlı", "Salata"]

extension FoodsDataSource: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionName = sections[section]
        return foods.filter({ $0.category == sectionName}).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood") as! MainFoodTitleTableViewCell
        
        let food = foods.filter({$0.category == sections[indexPath.section]})[indexPath.row]
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
    
}


