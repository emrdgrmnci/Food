//
//  MyPastOrdersViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 14.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class MyPastOrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    
    @IBOutlet weak var myPastOrdersTableView: UITableView!
    
    var food: Food?
    var fromSharedFood = SingletonCart.sharedFood.food
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Önceki Siparişlerim"
        myPastOrdersTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if fromSharedFood.count == 0 {
            myPastOrdersTableView.setEmptyView(title: "Sipariş bulunmamaktadır", message: "Geçmiş siparişler burada listelenir.")
        }
        else {
            myPastOrdersTableView.restore()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fromSharedFood.count == 0 {
            tableView.setEmptyView(title: "Sipariş bulunmamaktadır", message: "Geçmiş siparişler burada listelenir.")
        }
        else {
            tableView.restore()
        }
        
        return fromSharedFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodName = fromSharedFood[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPastOrderCell", for: indexPath) as! MyPastOrdersTableViewCell
        cell.selectedMenu.text = foodName.ProductTitle
        cell.selectedMenuPrice.text = foodName.PriceString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fromSharedFood.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
            if fromSharedFood.count == 0 {
                myPastOrdersTableView.setEmptyView(title: "Sipariş bulunmamaktadır", message: "Geçmiş siparişler burada listelenir.")
            }
            else {
                myPastOrdersTableView.restore()
            }
            tableView.endUpdates()
        }
    }
}
//MARK: If table view empty!
extension UITableView {
    func setPastOrdersEmptyView(title: String, message: String) {
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
    func pastOrdersRestore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
