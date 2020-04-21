//
//  LoginViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 20.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
//import Moya
import Firebase
import SwiftyJSON
import SwiftMessages

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var window: UIWindow?
    //    let loginProvider = MoyaProvider<LoginNetwork>()
    let loginUserDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let storedEmail = UserDefaults.standard.object(forKey: "email")
        let storedPassword = UserDefaults.standard.object(forKey: "password")

        if let email = storedEmail as? String {
            emailTextField.text = email
        }
        if let password = storedPassword as? String {
            passwordTextField.text = password
        }
        emailTextField.delegate = self
        passwordTextField.delegate = self

        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }


    func signInUser(email: String, password: String) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("User signed in")
                self.performSegue(withIdentifier: "loginToMain", sender: self)
                self.showStatusLine("Logged in successfully!")
            } else {
                print(error ?? "error")
                print(error?.localizedDescription ?? "error")
                let alert = UIAlertController(title: error!.localizedDescription, message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true, completion: nil)
                    self.isLoading(false)
                })
            }
        }
    }

    func showStatusLine(_ message: String) {
        let view: MessageView = try! SwiftMessages.viewFromNib(named: "StatusLine")
        SwiftMessages.show(view: view)
        view.bodyLabel?.text = message
    }

    @IBAction func loginButton(_ sender: Any) {
        // MARK: - UserDefaults
        UserDefaults.standard.set(emailTextField.text, forKey: "email")
        UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        signInUser(email: emailTextField!.text!, password: passwordTextField!.text!)
        self.isLoading(true)
    }
    //MARK:- dismissKeyboard for email password fields
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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
