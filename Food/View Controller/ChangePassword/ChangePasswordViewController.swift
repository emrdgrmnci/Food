//
//  ChangePasswordViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 8.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class ChangePasswordViewController: UIViewController {
    
    let changePasswordProvider = MoyaProvider<ChangePasswordNetwork>()
    
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordAgain: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.title = "Şifre Değiştir"
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currentPassword.resignFirstResponder()
        newPassword.resignFirstResponder()
        newPasswordAgain.resignFirstResponder()
    }
    
    @IBAction func changePasswordButton(_ sender: Any) {
        
        self.isLoading(true)
        let currentPasswordText = currentPassword.text
        let newPasswordText = newPassword.text
        let newPasswordAgainText = newPasswordAgain.text
        changePasswordProvider.request(.changePassword(currentPasswordText!, newPasswordText!, newPasswordAgainText!)) {
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
                        let changePasswordResponse = try JSONDecoder().decode(ChangePasswordServiceResponse.self, from: response.data)
                        
                        if (changePasswordResponse.Success!) {
                            print(json.debugDescription)
                            self?.showAlert(withTitle: "Başarılı", withMessage: changePasswordResponse.Message!, withAction: "pop")
                            self!.currentPassword.text = ""
                            self!.newPassword.text = ""
                            self!.newPasswordAgain.text = ""
                        } else {
                            self?.showAlert(withTitle: "Hata", withMessage: changePasswordResponse.Message!, withAction: "pop")
                        }
                    } catch {
                        print("change password error")
                    } default :
                        self!.isLoading(false)
                    break //Error handler
                }
            case .failure(let error):
                self!.isLoading(false)
                self!.showError(error.response!)
                self?.showAlert(withTitle: "Hata", withMessage: "Şifre Değiştirilememektedir!", withAction: "pop")
                if let code = error.response?.statusCode {
                    if code == 401 {
                        self?.showAlert(withTitle: "Hata", withMessage: "Şifre Değiştirilememektedir!", withAction: "pop")
                    }
                }
            }
        }
    }
}



