//
//  MyAddressesViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 14.05.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import Moya

class MyAddressesViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let provider = MoyaProvider<GetAddressNetwork>()
    
    var addressType: [String] = ["Seçiniz"]
    var getAddressList: [AddressPost] = []
    
    override func viewDidLayoutSubviews() {
        self.scrollView.contentSize = CGSize(width: 320, height: 700)
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.contentSize.height = 700
        view.backgroundColor = .white
        return view
    }()
    
    lazy var selectedAddressTextView: KMPlaceholderTextView = {
        let cityTf = KMPlaceholderTextView()
        cityTf.layer.cornerRadius = 8
        cityTf.layer.borderWidth = 1
        cityTf.layer.borderColor = UIColor.lightGray.cgColor
        cityTf.placeholder = "Adres başlığı seçiniz!"
        return cityTf
    }()
    
    lazy var addressTitleTextField: UITextField = {
        let addressTitleTf = UITextField()
        addressTitleTf.layer.cornerRadius = 8
        addressTitleTf.layer.borderWidth = 1
        addressTitleTf.layer.borderColor = UIColor.lightGray.cgColor
        addressTitleTf.placeholder = "Adres Başlığı"
        return addressTitleTf
    }()
    
    lazy var addressTextView: KMPlaceholderTextView = {
        let addressTv = KMPlaceholderTextView()
        addressTv.layer.cornerRadius = 8
        addressTv.layer.borderWidth = 1
        addressTv.layer.borderColor = UIColor.lightGray.cgColor
        addressTv.font = UIFont.systemFont(ofSize: 18)
        addressTv.placeholder = "Adres"
        return addressTv
        
    }()
    
    lazy var shortAddressTextView: KMPlaceholderTextView = {
        let shortAddressTv = KMPlaceholderTextView()
        shortAddressTv.layer.cornerRadius = 8
        shortAddressTv.layer.borderWidth = 1
        shortAddressTv.layer.borderColor = UIColor.lightGray.cgColor
        shortAddressTv.font = UIFont.systemFont(ofSize: 18)
        shortAddressTv.placeholder = "Kısa Adres Tarifi"
        return shortAddressTv
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTitleTextField.isEnabled = false
        addressTextView.isUserInteractionEnabled = false
        shortAddressTextView.isUserInteractionEnabled = false
        
        self.navigationItem.title = "Adreslerim"
        self.view.addSubview(scrollView)
        setupScrollView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        getAddressFunc()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        
        selectedAddressTextView.resignFirstResponder()
        addressTitleTextField.resignFirstResponder()
        addressTextView.resignFirstResponder()
        shortAddressTextView.resignFirstResponder()
    }
    
    func setupScrollView() {
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        selectedAddressTextView.translatesAutoresizingMaskIntoConstraints = false
        addressTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextView.translatesAutoresizingMaskIntoConstraints = false
        shortAddressTextView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(addressTitleTextField)
        
        addressTitleTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addressTitleTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        addressTitleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addressTitleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        scrollView.addSubview(selectedAddressTextView)
        
        selectedAddressTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        selectedAddressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 150).isActive = true
        selectedAddressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        selectedAddressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        scrollView.addSubview(addressTextView)
        
        addressTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200).isActive = true
        addressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        scrollView.addSubview(shortAddressTextView)
        
        shortAddressTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        shortAddressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 300).isActive = true
        shortAddressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        shortAddressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let addressPicker = UIPickerView()
        addressPicker.delegate = self
        addressTextView.inputView = addressPicker
        
        let image = UIImage(named: "Tamam") as UIImage?  //w:295, h: 45
        let imageSize: CGSize = CGSize(width: 45, height: 45)
        let approveButton = UIButton(type: UIButton.ButtonType.custom)
        approveButton.translatesAutoresizingMaskIntoConstraints = false
        approveButton.tintColor = .white
        approveButton.frame = CGRect(x: 0, y: 0, width: 350, height: 135)
        approveButton.setImage(image, for: .normal)
        approveButton.addTarget(self, action: #selector(approveButtonAction), for: .touchUpInside)
        
        approveButton.imageEdgeInsets = UIEdgeInsets(
            top: (approveButton.frame.size.height - imageSize.height) / 2,
            left: (approveButton.frame.size.width - imageSize.width) / 2.5,
            bottom: (approveButton.frame.size.height - imageSize.height) / 2,
            right: (approveButton.frame.size.width - imageSize.width) / 2.5)
        
        
        scrollView.addSubview(approveButton)
        
        approveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        approveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        approveButton.topAnchor.constraint(equalTo: shortAddressTextView.bottomAnchor, constant: 20).isActive = true
        approveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        approveButton.widthAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2).isActive = true
        approveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        //MARK: Delete button
        let deleteButton = UIButton(type: UIButton.ButtonType.custom)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.tintColor = .white
        deleteButton.frame = CGRect(x: 0, y: 0, width: 350, height: 135)
        deleteButton.setImage(image, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        deleteButton.imageEdgeInsets = UIEdgeInsets(
            top: (deleteButton.frame.size.height - imageSize.height) / 2,
            left: (deleteButton.frame.size.width - imageSize.width) / 2.5,
            bottom: (deleteButton.frame.size.height - imageSize.height) / 2,
            right: (deleteButton.frame.size.width - imageSize.width) / 2.5)
        
        
        scrollView.addSubview(deleteButton)
        
        deleteButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        deleteButton.topAnchor.constraint(equalTo: approveButton.bottomAnchor, constant: 20).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    
    //TODO: Approve Button for MyAddresses
    @objc func approveButtonAction(sender: UIButton!) {
        
    }
    
    //TODO: Delete Button for MyAddresses
    @objc func deleteButtonAction(sender: UIButton!) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addressType.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return addressType[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        addressText.text = addressType[row]
        if addressTextView.isFirstResponder {
            if row != 0 {
                selectedAddressTextView.text = getAddressList[row - 1].A
                
                let itemSelected = addressType[row]
                addressTextView.text = itemSelected
            }
    }
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
                        
                        debugPrint("Mehmet \(userResponse.ResultList![0].A)" )
                        self!.addressTitleTextField.text = userResponse.ResultList![0].T
                        self!.addressTextView.text = userResponse.ResultList![0].A //Açık Adres
                        self!.shortAddressTextView.text = userResponse.ResultList![0].AR //Adres Tarifi
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
    
}

