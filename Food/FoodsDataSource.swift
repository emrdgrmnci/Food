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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if indexPath.section == 0 {
        //                        let cell = tableView.dequeueReusableCell(withIdentifier: "MainFoodTableViewCell", for: indexPath) as! MainFoodCollectionViewCell
        //
        //                        //            cell.mainFoodCollectionView.delegate = self
        //                        //            cell.mainFoodCollectionView.dataSource = self
        //                        //            cell.mainFoodCollectionView.reloadData()
        //
        //            cell.mainFoodImage.image =
        //                        return cell
        //
        //                    } else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood") as! MainFoodTitleTableViewCell
        let food = foods[indexPath.row]
        cell.title = food.name
        cell.price = food.price
        return cell
    }
    
}
//}
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MainFoodTableViewCell", for: indexPath) as! MainFoodTableViewCell
//
//            //            cell.mainFoodCollectionView.delegate = self
//            //            cell.mainFoodCollectionView.dataSource = self
//            //            cell.mainFoodCollectionView.reloadData()
//            cell.mainFoodCollectionView.tag = indexPath.row
//            return cell
//
//        } else {
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood", for: indexPath) as! MainFoodTitleTableViewCell
//
//            //            if searching {
//            //                cell.titleLabel?.text = filtered[indexPath.row]
//            //                cell.priceLabel?.text = priceFood[indexPath.row].description
//            //            } else {
//            cell.titleLabel?.text = searchFoods[indexPath.row]
//            cell.priceLabel?.text = priceFood[indexPath.row].description
//            return cell
//        }
//
//    }

extension FoodsDataSource: UICollectionViewDataSource, UICollectionViewDelegate {
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


