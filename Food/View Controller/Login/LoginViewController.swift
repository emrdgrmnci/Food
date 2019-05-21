//
//  LoginViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 20.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var window: UIWindow?
    
    //TODO:
    @IBAction func loginButton(_ sender: Any) {
        
        if isValidInfo() {
            self.isLoading(true)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        self.window?.rootViewController = viewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //MARK:- For cancelBarButtonItem of LoginView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "cancel" :
            print("cancel bar button item tapped")
        default:
            print("unexpected segue identifier")
        }
    }
  
    //MARK:- Email and password field control
    func isValidInfo() -> Bool {
        
        guard emailTextField.text?.isEmpty == false, (emailTextField.text?.isValidEmail)! else {
            self.showAlertController("E-mail alanı boş geçilemez!")
            return false
        }
        guard passwordTextField.text?.isEmpty == false, (passwordTextField.text?.count)! >= 6 else {
            self.showAlertController("Şifre alanı boş geçilemez!")
            return false
        }
        return true
    }

    
}
