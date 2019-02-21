//
//  FoodMainViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class FoodMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     var foodNames = [FoodNames]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodNames = [
            FoodNames(title: "Hamburger hamburger big king big mac big chicken")
        ]
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellForFood", for: indexPath) as? MainFoodTitleTableViewCell
        
        let food: FoodNames
        food = foodNames[indexPath.row]
        cell?.textLabel!.text = food.title
        
        return cell!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
