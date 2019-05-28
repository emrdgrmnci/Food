//
//  LoginViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 20.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var window: UIWindow?
    
    let provider = MoyaProvider<GetAddressNetwork>()
    
    
    func loginBtnTapped() {
        
        
            isLoading(true)
            let email = "EMRE)"
            let pass = "123123123"
            provider.request(.postLogin(email, pass)) { [weak self] result in
                guard self != nil else { return }
                //debugPrint(result)
                
//                let statusCode = result.value?.statusCode
                switch result {
                case .success(let response):
                    do {
                        print(try response.mapJSON())
                        
                        let data = response.data
                        let json = try JSON(data: data)
                        print(json)
                    } catch {
                        print("error1")
                        self!.isLoading(false)
                    }
                case .failure(let error):
                    
                    self!.isLoading(false)
                    
                    print(error.response?.statusCode as Any)
//                    self!.showError(error.response!)
//                    if let code = error.response?.statusCode {
//                        if code == 401 {
//                            self?.toLogin()
//                        }
//                    }
                }
            }
        
            print("not valid info")
            self.isLoading(false)
        
    }
    
    
    
    
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
        
        loginBtnTapped()
        
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
