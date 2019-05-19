//
//  LoginViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 20.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var window: UIWindow?
    
    //TODO:
    @IBAction func loginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        self.window?.rootViewController = viewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func controlFields() -> Bool {
        var flag = false
        if emailTextField.text != "" && passwordTextField.text != "" && (passwordTextField.text?.count)! >= 8 && (passwordTextField.text?.count)! <= 20 {
            flag = true
        } else {
            flag = false
        }
        return flag
    }
    
    @IBAction func emailTextChanged(_ sender: Any) {
        if controlFields() {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func passwordTextChanged(_ sender: Any) {
        if controlFields() {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
}