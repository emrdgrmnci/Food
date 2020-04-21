//
//  RegisterViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 20.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
//import Moya
import Firebase
import FirebaseAuth
import SwiftyJSON
import SwiftMessages


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    //    let registerProvider = MoyaProvider<RegisterNetwork>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        
        self.nameTextField.delegate = self
        self.surnameTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.rePasswordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    func validateFields() -> String? {

        //Check that all fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            surnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            rePasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }

        //Check if the password secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }

    //TODO: Loading koy!
    @IBAction func registerButtonTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()

        if error != nil {

            //there's smth wrong with the fields, show error message

        } else {

            //Create cleaned versions of the data
            let firstName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = surnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let rePassword = rePasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

                //Check for errors
                if error != nil {

                    //There was an error creting the user
                    self.showStatusLine("Error creating user")
                } else {
                    //User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()

                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid, "email": email, "phone": phone, "password": password, "repassword": rePassword]) {(error) in

                        if error != nil {

                            //Show error message
                            self.showStatusLine("Error saving user data")
                        }
                    }
                    //Transition to the home screen
                    self.transitionToLoginView()
                }
            }
            self.isLoading(true)
            self.showStatusLine("You have signed up successfully!")
        }
    }

    func transitionToLoginView() {
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController

        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }

    func showStatusLine(_ message: String) {
        let view: MessageView = try! SwiftMessages.viewFromNib(named: "StatusLine")
        SwiftMessages.show(view: view)
        view.bodyLabel?.textColor = .green
        view.bodyLabel?.text = message
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

extension RegisterViewController: UITextFieldDelegate {
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
}


