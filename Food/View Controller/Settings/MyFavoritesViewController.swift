//
//  MyFavoritesViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 14.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class MyFavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var myFavoritesTableView: UITableView!
    
    let favoriteProvider = MoyaProvider<GetPostFavoriteListNetwork>()
    
    var favoriteList = [FavoriteList]()
    
    var food: Food?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFavoritesFunc()
        myFavoritesTableView.dataSource = self
        myFavoritesTableView.delegate = self
        self.navigationItem.title = "Favorilerim"
        myFavoritesTableView.reloadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if favoriteList.count == 0 {
//            myFavoritesTableView.setEmptyView(title: "Favori ürün bulunmamaktadır", message: "Favori ürünler burada listelenir.")
//        }
//        else {
//            myFavoritesTableView.restore()
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if favoriteList.count == 0 {
            tableView.setEmptyView(title: "Favori ürün bulunmamaktadır", message: "Favori ürünler burada listelenir.")
        }
        else {
            tableView.restore()
        }
        
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodName = favoriteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavorites", for: indexPath) as! MyFavoritesTableViewCell
        cell.myFavoritesTitle.text = foodName.ProductTitle
        cell.myFavoritesPrice.text = foodName.PriceString
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            postFavoritesFunc(favoriteID: favoriteList[indexPath.row].id)
            favoriteList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            if favoriteList.count == 0 {
                myFavoritesTableView.setEmptyView(title: "Favori ürün bulunmamaktadır", message: "Favori ürünler burada listelenir.")
            }
            else {
                myFavoritesTableView.restore()
            }
            tableView.endUpdates()
        }
    }
    
    func getFavoritesFunc() {
        favoriteProvider.request(.getFavoriteList) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        print(try response.mapJSON())
                        
                        let favoriteResponse = try JSONDecoder().decode(FavoriteListServiceResponse.self, from: response.data)
                        //                        detail = userResponse
                        
                        self!.favoriteList = favoriteResponse.ResultList!
                        print(favoriteResponse.ResultList!)
                        print(self?.favoriteList as Any)
                        self!.myFavoritesTableView.reloadData()
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
    
    
    func postFavoritesFunc(favoriteID: Int) {
        favoriteProvider.request(.postDeleteFavorite(favoriteID)) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        print(try response.mapJSON())
                        
                        let favoriteResponse = try JSONDecoder().decode(FavoriteListServiceResponse.self, from: response.data)
                        //                        detail = userResponse
                        
                        self!.myFavoritesTableView.reloadData()
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

}

//MARK: If table view empty!

extension UITableView {
    func setMyFavoritesEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.red
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func myFavoritesRestore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

