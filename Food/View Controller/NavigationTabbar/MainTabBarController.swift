//
//  MainTabBarController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 28.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.object(forKey: "userID") as? String ?? "")//Buradan user name surname getirilebilirsayfa titleında
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            
            if let mainNavigationController = viewController as? MainNavigationController {
                
                if (mainNavigationController.viewControllers.first as? MainViewController) != nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "Sipariş")
                    self.window?.rootViewController = viewController
                }
                
            }
        }
        
    }
}
