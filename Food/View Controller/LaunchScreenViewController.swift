//
//  LaunchScreenViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 9.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    var window: UIWindow!
    
    @IBOutlet var animationView: AnimationView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
        
        //MARK: Splash screen animation time delay
        perform(#selector(LaunchScreenViewController.showMainScreen), with: nil, afterDelay: 1.5)
    }
    
    func startAnimation() {
        animationView.animation = Animation.named("5326-loading-10-cooker")
        animationView.play()
    }
    
    @objc func showMainScreen() {
        performSegue(withIdentifier: "showMainScreenSegue", sender: self)
    }
    
}
