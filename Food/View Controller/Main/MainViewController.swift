//
//  MainViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainCollectionView: UICollectionView!

    var sliderData = [String]()
    var foodData = [Food]()
    var foodSection = 0
    var foodRow = 0
    var root: Root?

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.navigationController?.navigationBar.barTintColor = .red
            let data = try Data(contentsOf: Bundle.main.url(forResource: "default", withExtension: "json")!)
            root = try? JSONDecoder().decode(Root.self, from: data)
            if let root = root {
                print(root)
            }
            mainTableView.reloadData()

        } catch { print(error) }

        print("User ID: \(UserDefaults.standard.object(forKey: "userID") as? Int ?? 0)")
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray3]

        mainTableView.delegate = self
        mainTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
    }

    //MARK: Segue from MainVC to DetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedFoodToDetail" {
            let controller = segue.destination as! DetailViewController
            controller.food = root?.category[foodSection].foods[foodRow]
        }
    }

}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        foodSection = indexPath.section
        foodRow = indexPath.row
        performSegue(withIdentifier: "selectedFoodToDetail", sender: self)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return root?.category[section].name
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return (root?.category.count)!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (root?.category[section].foods.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood", for: indexPath) as! MainFoodTitleTableViewCell
        let categoryNames = root?.category[indexPath.section]
        let foodNames = categoryNames?.foods[indexPath.row]
        cell.titleLabel.text = foodNames?.productTitle
        cell.priceLabel.text = foodNames?.priceString
        return cell
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    //MARK:- collection view cell size
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    //MARK:- //collection view cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFoodCollectionViewCell", for: indexPath) as! MainFoodCollectionViewCell
        let imgages : UIImage = UIImage(named:"salata")!
        cell.mainFoodImage.image = imgages
        return cell
    }
}
