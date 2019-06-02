//
//  RegisterViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 20.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON


class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    let registerProvider = MoyaProvider<RegisterNetwork>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        
        self.nameTextField.delegate = self
        self.surnameTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.rePasswordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    //TODO: Loading koy!
    @IBAction func registerButtonTapped(_ sender: Any) {
        switch isValid() {
        case true:
            self.isLoading(true)
            let name = nameTextField.text
            let surname = surnameTextField.text
            let email = emailTextField.text
            let phone = phoneTextField.text
            let password = passwordTextField.text
            let rePassword = rePasswordTextField.text
            registerProvider.request(.register(name!, surname!, email!, phone!, password!, rePassword!)) {
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
                            
                            if (userResponse.Success) {
                                
                                print(json.debugDescription)
                                self?.performSegue(withIdentifier: "register", sender: nil)
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
                    self?.showAlert(withTitle: "Hata", withMessage: "KAYITLISIN!", withAction: "pop")
                    if let code = error.response?.statusCode {
                        if code == 401 {
                            self?.showAlert(withTitle: "Hata", withMessage: "KAYITLISIN!", withAction: "pop")
                        }
                    }
                }
            }
        default: break
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if phoneTextField == textField && phoneTextField.text?.count == 13 {
            
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if nameTextField == textField || surnameTextField == textField {
            if string.count < 10 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: " ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZXWabcçdefgğhıijklmnoöprsştuüvyzxw").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        else if phoneTextField == textField {
            if string.count < 10 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "1234567890").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            } 
        }
            
        else if emailTextField == textField || passwordTextField == textField || rePasswordTextField == textField {
            if string.count < 10 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "@.*-=;!?[]{}|/&($+%^'ABCÇDEFGĞHIİJKLMNOÖPRQSŞTUÜVYZXWabcçdefgğhıijklmnoöprsqştuüvyzxw1234567890").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        return result
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        rePasswordTextField.resignFirstResponder()
        
        nameTextField.delegate = self
        surnameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        rePasswordTextField.delegate = self
        
    }
    
    
    
    //MARK: TextField validations
    
    func isValid() -> Bool{
        
        
        guard nameTextField.text?.isEmpty == false else {
            self.showAlertController("İsim alanı boş geçilemez.")
            return false
        }
        
        guard surnameTextField.text?.isEmpty == false else {
            self.showAlertController("Soyisim alanı boş geçilemez.")
            return false
        }
        
        
        guard emailTextField.text?.isValidEmail == true, emailTextField.text?.isEmpty == false else {
            emailTextField.isEnabled = false
            self.showAlertController("E-mail alanı boş geçilemez.")
            return false
        }
        
        guard phoneTextField.text?.isEmpty == false, phoneTextField.text!.count == 10 else {
            self.showAlertController("Telefon alanı boş olamaz.")
            return false
        }
        
        guard rePasswordTextField.text?.isEmpty == false, passwordTextField.text!.count >= 8 else {
            self.showAlertController("Şifrenizin uzunluğu en az 8 karakter olmalı.")
            return false
        }
        guard rePasswordTextField.text == passwordTextField.text else {
            self.showAlertController("Girilen şifreler uyuşmuyor.")
            
            return false
        }
        return true
        
    }
    
    
    
    //MARK:- For cancelBarButtonItem of RegisterView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "cancel" :
            print("cancel bar button item tapped")
        default:
            print("unexpected segue identifier")
        }
    }
    
}


