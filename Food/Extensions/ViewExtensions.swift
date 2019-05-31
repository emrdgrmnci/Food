//
//  ViewExtensions.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 21.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import SwiftyJSON
import Moya

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
    func showError(_ response: Response) {
        do {
            let json = try JSON(data: response.data)
            let message = json["message"] .string
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    func showAlert(withTitle title: String, withMessage message: String, withAction act: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            if act == "pop" {
                self.navigationController?.popViewController(animated: true)
            } else if act == "root" {
                self.navigationController?.popToRootViewController(animated: false)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertController(_ message: String) { // TODO: Update for error handling
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func toLogin() {
        //        UserDefaults.standard.removeObject(forKey: "token")
        //        UserDefaults.standard.removeObject(forKey: "userID")
        //        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
        present(vc, animated: true, completion: nil)
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

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
