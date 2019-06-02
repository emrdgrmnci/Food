//
//  MainNavigationController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 28.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
//     var window: UIWindow?
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        if isLoggedIn() {
            //assume user is logged in
            let mainController = MainViewController(coder: NSCoder())
            viewControllers = [mainController] as! [UIViewController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    @objc func showLoginController() {
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: {
            //perhaps we'll do sth here later
        })
    }
}
