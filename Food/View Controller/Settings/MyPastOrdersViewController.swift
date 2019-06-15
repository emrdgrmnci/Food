//
//  MyPastOrdersViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 14.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class MyPastOrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var myPastOrdersTableView: UITableView!
    
    var pastOrder = [PastOrders]()
    let provider = MoyaProvider<GetPastOrdersNetwork>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPastOrdersFunc()
        self.navigationItem.title = "Siparişlerim"
        myPastOrdersTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if pastOrder.count == 0 {
            myPastOrdersTableView.setEmptyView(title: "Sipariş bulunmamaktadır", message: "Siparişleriniz burada listelenir.")
        }
        else {
            myPastOrdersTableView.restore()
        }
    }
    
    func getPastOrdersFunc() {
        provider.request(.getPastOrdersList) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        print(try response.mapJSON())
                        
                        let pastOrderResponse = try JSONDecoder().decode(PastOrdersServiceResponse.self, from: response.data)
                        //                        detail = userResponse
                        
                        self!.pastOrder = pastOrderResponse.ResultList!
                        self!.myPastOrdersTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pastOrder.count == 0 {
            tableView.setEmptyView(title: "Sipariş bulunmamaktadır", message: "Siparişleriniz burada listelenir.")
        }
        else {
            tableView.restore()
        }
        
        return pastOrder.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pastOrderInfos = pastOrder[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPastOrderCell", for: indexPath) as! MyPastOrdersTableViewCell
        cell.pastOrderNumber.text = pastOrderInfos.ActionNumber
        cell.pastOrderDate.text = pastOrderInfos.CreatedDateString
        cell.pastOrderPrice.text = pastOrderInfos.PriceCountString
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

