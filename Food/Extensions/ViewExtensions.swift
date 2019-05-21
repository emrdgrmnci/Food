//
//  ViewExtensions.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import Lottie

extension UIViewController {
    
    func addBlurLayer() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 1000
        blurEffectView.frame = self.view.bounds // TODO : Does not contain Navigation Controller
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        self.view.addSubview(blurEffectView)
        UIView.animate(withDuration: 0.5) {
            blurEffectView.alpha = 0.7
        }
    }
    
    func removeBlurLayer() {
        UIView.animate(withDuration: 0.5) {
            self.view.viewWithTag(1000)?.alpha = 0
        }
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    func showAlertController(_ message: String) { // TODO: Update for error handling
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func isLoading(_ state: Bool) {
        switch state {
        case true:
            addBlurLayer()
            let animationView = AnimationView(name: "5326-loading-10-cooker", bundle: Bundle(path: Bundle.main.path(forResource: "Animations", ofType: "bundle")!)!)
            animationView.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100)
            animationView.center = self.view.center
            self.view.addSubview(animationView)
            animationView.loopMode = LottieLoopMode.loop
            animationView.play()
        case false:
            for subview in self.view.subviews {
                if subview is AnimationView {
                    subview.removeFromSuperview()
                    removeBlurLayer()
                }
            }
        }
    }
}
