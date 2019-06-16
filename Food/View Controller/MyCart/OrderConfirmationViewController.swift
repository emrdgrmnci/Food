//
//  OrderConfirmationViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 2.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
//import TinyConstraints
import KMPlaceholderTextView
import Moya
import SwiftyJSON

//TODO: Detaydaki yemek içeriklerini burayada getir

class OrderConfirmationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var addressType: [String] = ["Seçiniz"]
    var paymentMethod: [String] = []
    var getAddressList: [AddressPost] = []
    
    var activeTextField = UITextField()
    
    let provider = MoyaProvider<GetPostAddressNetwork>()
    
    let fromSharedFood = SingletonCart.sharedFood.food
    
    @IBAction func approveButton(_ sender: Any) {
        
    }
    
    func getAddressFunc() {
        provider.request(.getAddressList) { [weak self] result in
            guard self != nil else {return}
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    do {
                        print(try response.mapJSON())
                        
                        let userResponse = try JSONDecoder().decode(AddressPostResponse.self, from: response.data)
                        //                        detail = userResponse
                        
                        self!.getAddressList = userResponse.ResultList!
                        
                        for item in userResponse.ResultList! {
                            self!.addressType.append(item.T)
                        }
                    } catch {
                        print("Error info: \(error)")
                    }
                }
            case .failure(let error):
                self!.isLoading(false)
                print(error.response!)
            }
            
        }
    }

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 700
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: Telefon numarasını MyInfosa Taşı
    
//    lazy var phoneTextField: UITextField = {
//        let phoneTf = UITextField()
//        phoneTf.layer.cornerRadius = 8
//        phoneTf.layer.borderWidth = 1
//        phoneTf.layer.borderColor = UIColor.lightGray.cgColor
//        phoneTf.placeholder = "Cep Telefonu"
//        return phoneTf
//    }()
    
    lazy var selectedAddressTextView: KMPlaceholderTextView = {
        let cityTf = KMPlaceholderTextView()
        cityTf.layer.cornerRadius = 8
        cityTf.layer.borderWidth = 1
        cityTf.layer.borderColor = UIColor.lightGray.cgColor
        cityTf.placeholder = "Adres başlığı seçiniz!"
        return cityTf
    }()
    
    lazy var addressText: UITextField = {
        let addressTv = UITextField()
        addressTv.layer.cornerRadius = 8
        addressTv.layer.borderWidth = 1
        addressTv.layer.borderColor = UIColor.lightGray.cgColor
        addressTv.font = UIFont.systemFont(ofSize: 18)
        addressTv.placeholder = "Adres Başlığı"
        return addressTv
        
    }()
    
    
    lazy var paymentText: UITextField = {
        let paymentTf = UITextField()
        paymentTf.layer.cornerRadius = 8
        paymentTf.layer.borderWidth = 1
        paymentTf.layer.borderColor = UIColor.lightGray.cgColor
        paymentTf.font = UIFont.systemFont(ofSize: 18)
        paymentTf.placeholder = "Ödeme Tipi"
        return paymentTf
        
    }()
    
    lazy var explanationTextView: KMPlaceholderTextView = {
        let explanationTv = KMPlaceholderTextView()
        explanationTv.layer.cornerRadius = 8
        explanationTv.layer.borderWidth = 1
        explanationTv.layer.borderColor = UIColor.lightGray.cgColor
        explanationTv.font = UIFont.systemFont(ofSize: 18)
        explanationTv.placeholder = "Açıklama"
        return explanationTv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        setupScrollView()
//        resetTotalPrice()
        
        getAddressFunc()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Siparişi Onayla"
        
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
//        phoneTextField.resignFirstResponder()
        selectedAddressTextView.resignFirstResponder()
        addressText.resignFirstResponder()
        paymentText.resignFirstResponder()
        explanationTextView.resignFirstResponder()
    }
    
    func setupScrollView() {
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
//        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        selectedAddressTextView.translatesAutoresizingMaskIntoConstraints = false
        addressText.translatesAutoresizingMaskIntoConstraints = false
        paymentText.translatesAutoresizingMaskIntoConstraints = false
        explanationTextView.translatesAutoresizingMaskIntoConstraints = false
        
//        scrollView.addSubview(phoneTextField)
        
//        phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        phoneTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
//        phoneTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        phoneTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        scrollView.addSubview(addressText)
        
        addressText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addressText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        addressText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addressText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView.addSubview(selectedAddressTextView)
        
        selectedAddressTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        selectedAddressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80).isActive = true
        selectedAddressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        selectedAddressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let addressPicker = UIPickerView()
        addressPicker.delegate = self
        addressText.inputView = addressPicker
        
        scrollView.addSubview(paymentText)
        
        paymentText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        paymentText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 175).isActive = true
        paymentText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        paymentText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let paymentPicker = UIPickerView()
        paymentPicker.delegate = self
        paymentText.inputView = paymentPicker
        paymentMethod = ["Nakit", "Kredi Kartı"]
        
        scrollView.addSubview(explanationTextView)
        
        explanationTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        explanationTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 240).isActive = true
        explanationTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        explanationTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let totalLabel = UILabel()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.textColor = .white
        totalLabel.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        totalLabel.text = "Toplam: 22.0₺"
        
        view.addSubview(totalLabel)
        
        totalLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        totalLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        totalLabel.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 2/3).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        let approveButton = UIButton()
        approveButton.translatesAutoresizingMaskIntoConstraints = false
        approveButton.tintColor = .white
        approveButton.addTarget(self, action: #selector(approveButtonAction), for: .touchUpInside)
        approveButton.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.5450980392, blue: 0.2392156863, alpha: 1)
        
        approveButton.setTitle("Siparişi Onayla", for: .normal)
        
        view.addSubview(approveButton)
        
        approveButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        approveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        approveButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2).isActive = true
        approveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        var tempTotalPrice = 0 as Decimal
        
        for sharedFoodTotalPrice in fromSharedFood {
            tempTotalPrice += (sharedFoodTotalPrice.Price * sharedFoodTotalPrice.foodQuantity!)
        }
        
        totalLabel.text = "Toplam: \(tempTotalPrice) ₺"
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if addressText.isFirstResponder {
            return addressType.count
        } else if paymentText.isFirstResponder {
            return paymentMethod.count
        }
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if addressText.isFirstResponder {
            return addressType[row]
        } else if paymentText.isFirstResponder {
            return paymentMethod[row]
        }
        else {
            return nil
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        addressText.text = addressType[row]
        if addressText.isFirstResponder {
            if row != 0 {
            selectedAddressTextView.text = getAddressList[row - 1].A
            
            let itemSelected = addressType[row]
    
            addressText.text = itemSelected
            }
        } else if paymentText.isFirstResponder {
            let itemSelected = paymentMethod[row]
            paymentText.text = itemSelected
        }
        
    }
    //TODO: Approve Button
    @objc func approveButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
