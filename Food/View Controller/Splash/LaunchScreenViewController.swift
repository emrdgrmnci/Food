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
    
//    @IBOutlet var animationView: AnimationView!
    
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
        
        setupLayout()
    
        //MARK: Splash screen animation time delay
        perform(#selector(LaunchScreenViewController.showMainScreen), with: nil, afterDelay: 1.5)
    }
    
    func startAnimation() {
        let animationView = AnimationView(name: "5326-loading-10-cooker", bundle: Bundle(path: Bundle.main.path(forResource: "Animations", ofType: "bundle")!)!)
        animationView.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 250, height: 250)
        animationView.center = self.view.center
        self.view.addSubview(animationView)
        animationView.play()
    }
    
    private func setupLayout() {
        
        self.view.addSubview(tezzFoodLabel)
        
//        tezzFoodLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        tezzFoodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tezzFoodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
//        tezzFoodLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tezzFoodLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        tezzFoodLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
//        tezzFoodLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 105).isActive = true
//        tezzFoodLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
//        tezzFoodLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -310).isActive = true
    }
    
    
    @objc func showMainScreen() {
        performSegue(withIdentifier: "showMainScreenSegue", sender: self)
    }
    
}
