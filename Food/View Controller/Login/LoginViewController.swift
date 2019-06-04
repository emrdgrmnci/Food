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
    
    let loginProvider = MoyaProvider<LoginNetwork>()
    let loginUserDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = loginUserDefaults.string(forKey: "userEmail")
    }
    
    //TODO:
    @IBAction func loginButton(_ sender: Any) {
        
        switch isValidInfo() {
        case true:
            self.isLoading(true)
            let email = emailTextField.text
            let password = passwordTextField.text
            loginProvider.request(.login(email!, password!)) {
                [weak self] result in
                guard self != nil else { return }
                let statusCode = result.value?.statusCode
                switch result {
                case .success(let response):
                    switch statusCode {
                    case 200:
                        self!.isLoading(false)
                        do {
                            let data = response.data
                            let json = try JSON(data: data)
                            let userResponse = try JSONDecoder().decode(RegisterServiceResponse.self, from: response.data)
                            //                            print(userResponse)
                            if (userResponse.Success) {
                                
                                self?.loginUserDefaults.set(userResponse.ResultObj?.I, forKey: "userID")//UserID her işlem için lazım!
                                
                                print(json.debugDescription)
                                //                                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                                //                                guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
                                //                                mainNavigationController.viewControllers = [MainViewController(coder: NSCoder())] as! [UIViewController]
                                UserDefaults.standard.synchronize()
                                self!.loginUserDefaults.set(self!.emailTextField.text, forKey: "userEmail")
                                //                                self!.dismiss(animated: true, completion: nil)
                                
                                self?.performSegue(withIdentifier: "loginToMain", sender: nil)
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                                self!.window?.rootViewController = viewController
                            } else {
                                self?.showAlert(withTitle: "Hata", withMessage: userResponse.Message!, withAction: "pop")
                            }
                        } catch {
                            print("register error")
                        } default :
                            self!.isLoading(false)
                        break //Error handler
                    }
                case .failure(let error):
                    self!.isLoading(false)
                    self!.showError(error.response!)
                    self?.showAlert(withTitle: "Hata", withMessage: "Bir hata oluştu!", withAction: "pop")
                    if let code = error.response?.statusCode {
                        if code == 401 {
                            self?.showAlert(withTitle: "Hata", withMessage: "Bir hata oluştu!", withAction: "pop")
                        }
                    }
                }
            }
        case false:
            self.showAlert(withTitle: "Hata", withMessage: "Bir hata oluştu!", withAction: "pop")
            self.isLoading(false)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = loginUserDefaults.string(forKey: "userEmail")
        
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
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //
    //        guard let identifier = segue.identifier else {return}
    //
    //        switch identifier {
    //        case "cancel" :
    //            print("cancel bar button item tapped")
    //        default:
    //            print("unexpected segue identifier")
    //        }
    //    }
    
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
