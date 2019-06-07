//
//  MyInfosViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 14.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import Kingfisher
import AVKit
import AVFoundation
import WebKit
import SafariServices
import Result

class MyInfosViewController: UIViewController {
    
    @IBOutlet weak var myNameTextField: UITextField!
    @IBOutlet weak var myLastNameTextField: UITextField!
    
    //    static let provider = MoyaProvider<ContentDetailNetwork>()
    let provider = MoyaProvider<GetInfoNetwork>()
    
    func getInfoFunc() {
        provider.request(.getInfo) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        print(try response.mapJSON())
                        
                        let userResponse = try JSONDecoder().decode(UserInfoServiceResponse.self, from: response.data)
                        //                        detail = userResponse
                        
                        debugPrint(userResponse)
//                        debugPrint("Mehmet \(userResponse.ResultList![0].N )" )
//                        debugPrint("Mehmet \(userResponse.ResultList![0].S )" )
                        self!.myNameTextField.text = userResponse.ResultObj?.N
                        self!.myLastNameTextField.text = userResponse.ResultObj?.S
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
    @IBAction func showChangePasswordVC(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ChangePassword")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    @IBAction func showWebPage(_ sender: Any) {
        if let url = URL(string: "http://mehmetguner.pryazilim.com") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
            vc.preferredBarTintColor = .red
            vc.preferredControlTintColor = .white
        }
    }
    
    let settingList = ["Şifre Değiştir", "Web Sayfası"]
    let identities = ["ChangePassword"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfoFunc()
        self.navigationItem.title = "Bilgilerim"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        myNameTextField.resignFirstResponder()
        myLastNameTextField.resignFirstResponder()
    }
}


