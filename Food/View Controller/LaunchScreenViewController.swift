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
    
    let tezzFoodLabel: UILabel = {
        let tezzLabel = UILabel()
        tezzLabel.textColor = .white
        tezzLabel.text = "TezzFood"
        tezzLabel.font = UIFont(name: "American Typewriter", size: 32)
        tezzLabel.translatesAutoresizingMaskIntoConstraints = false
        return tezzLabel
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
        
        view.addSubview(tezzFoodLabel)
        
        setupLayout()
    
        //MARK: Splash screen animation time delay
        perform(#selector(LaunchScreenViewController.showMainScreen), with: nil, afterDelay: 1.5)
    }
    
    func startAnimation() {
        animationView.animation = Animation.named("5326-loading-10-cooker")
        animationView.play()
    }
    
    private func setupLayout() {
        
        tezzFoodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        tezzFoodLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 105).isActive = true
        tezzFoodLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 130).isActive = true
        tezzFoodLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -310).isActive = true
    }
    
    
    @objc func showMainScreen() {
        performSegue(withIdentifier: "showMainScreenSegue", sender: self)
    }
    
}
