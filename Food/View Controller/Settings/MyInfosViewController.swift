//
//  MyInfosViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 14.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import SafariServices

class MyInfosViewController: UIViewController {

    @IBOutlet weak var myNameTextField: UITextField!
    @IBOutlet weak var myLastNameTextField: UITextField!
    
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
        }
    }
    
    let settingList = ["Şifre Değiştir", "Web Sayfası"]
    let identities = ["ChangePassword"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Bilgilerim"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        myNameTextField.resignFirstResponder()
        myLastNameTextField.resignFirstResponder()
    }
}
    
