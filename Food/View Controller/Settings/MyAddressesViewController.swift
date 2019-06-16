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
import SwiftyJSON

class MyAddressesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let provider = MoyaProvider<GetPostAddressNetwork>()
    
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
    
    lazy var addressTitleTextField: UITextField = {
        let addressTitleTf = UITextField()
        addressTitleTf.layer.cornerRadius = 8
        addressTitleTf.layer.borderWidth = 1
        addressTitleTf.layer.borderColor = UIColor.lightGray.cgColor
        addressTitleTf.placeholder = "Adres Başlığı"
        return addressTitleTf
    }()
    
    lazy var selectedAddressTextView: KMPlaceholderTextView = {
        let selectedAddressTV = KMPlaceholderTextView()
        selectedAddressTV.layer.cornerRadius = 8
        selectedAddressTV.layer.borderWidth = 1
        selectedAddressTV.layer.borderColor = UIColor.lightGray.cgColor
        selectedAddressTV.placeholder = "Adres başlığı seçiniz!"
        return selectedAddressTV
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
        
//        addressTitleTextField.isEnabled = false
//        addressTextView.isUserInteractionEnabled = false
//        shortAddressTextView.isUserInteractionEnabled = false
        
        
        self.view.addSubview(scrollView)
        setupScrollView()
        getAddressFunc()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.navigationItem.title = "Adreslerim"
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
        selectedAddressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70).isActive = true
        selectedAddressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        selectedAddressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        scrollView.addSubview(addressTextView)
        
        addressTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 170).isActive = true
        addressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        addressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        scrollView.addSubview(shortAddressTextView)
        
        shortAddressTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        shortAddressTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 270).isActive = true
        shortAddressTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        shortAddressTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let addressPicker = UIPickerView()
        addressPicker.delegate = self
        addressTitleTextField.inputView = addressPicker
        
        let image = UIImage(named: "TamamButton") as UIImage?  //w:295, h: 45
        let imageSize: CGSize = CGSize(width: 295, height: 45)
        let approveButton = UIButton(type: UIButton.ButtonType.custom)
        approveButton.translatesAutoresizingMaskIntoConstraints = false
        approveButton.tintColor = .white
        approveButton.frame = CGRect(x: 0, y: 0, width: 250, height: 135)
        approveButton.setImage(image, for: .normal)
        approveButton.addTarget(self, action: #selector(approveButtonAction), for: .touchUpInside)
        
        approveButton.imageEdgeInsets = UIEdgeInsets(
            top: (approveButton.frame.size.height - imageSize.height) / 2,
            left: (approveButton.frame.size.width - imageSize.width) / 2.5,
            bottom: (approveButton.frame.size.height - imageSize.height) / 2,
            right: (approveButton.frame.size.width - imageSize.width) / 2.5)
        
        
        scrollView.addSubview(approveButton)
        
        approveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        approveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        approveButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 370).isActive = true
//        approveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        approveButton.widthAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2).isActive = true
        approveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
//        //MARK: Edit button
//        let editButtonImage = UIImage(named: "EditButton") as UIImage?  //w:295, h: 45
//        let editButtonImageSize: CGSize = CGSize(width: 295, height: 45)
//        let editButton = UIButton(type: UIButton.ButtonType.custom)
//        editButton.translatesAutoresizingMaskIntoConstraints = false
//        editButton.tintColor = .white
//        editButton.frame = CGRect(x: 0, y: 0, width: 250, height: 135)
//        editButton.setImage(editButtonImage, for: .normal)
//        editButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
//
//        editButton.imageEdgeInsets = UIEdgeInsets(
//            top: (editButton.frame.size.height - editButtonImageSize.height) / 2,
//            left: (editButton.frame.size.width - editButtonImageSize.width) / 2.5,
//            bottom: (editButton.frame.size.height - editButtonImageSize.height) / 2,
//            right: (editButton.frame.size.width - editButtonImageSize.width) / 2.5)
//
//
//        scrollView.addSubview(editButton)
//
//        editButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        editButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        editButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 430).isActive = true
////        editButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        editButton.widthAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.widthAnchor).isActive = true
//        editButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        //MARK: Delete button
        let deleteButtonImage = UIImage(named: "DeleteButton") as UIImage?  //w:295, h: 45
        let deleteButtonImageSize: CGSize = CGSize(width: 295, height: 45)
        let deleteButton = UIButton(type: UIButton.ButtonType.custom)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.tintColor = .white
        deleteButton.frame = CGRect(x: 0, y: 0, width: 250, height: 135)
        deleteButton.setImage(deleteButtonImage, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        deleteButton.imageEdgeInsets = UIEdgeInsets(
            top: (deleteButton.frame.size.height - deleteButtonImageSize.height) / 2,
            left: (deleteButton.frame.size.width - deleteButtonImageSize.width) / 2.5,
            bottom: (deleteButton.frame.size.height - deleteButtonImageSize.height) / 2,
            right: (deleteButton.frame.size.width - deleteButtonImageSize.width) / 2.5)
        
        
        scrollView.addSubview(deleteButton)
        
        deleteButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        deleteButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 430).isActive = true
//        deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.widthAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    
    //TODO: Approve Button for MyAddresses
    @objc func approveButtonAction(sender: UIButton!) {
        
    }
    
//    //TODO: Delete Button for MyAddresses
//    @objc func editButtonAction(sender: UIButton!) {
//
//    }
    
    //TODO: Delete Button for MyAddresses
    @objc func deleteButtonAction(sender: UIButton!) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if addressTitleTextField.isFirstResponder {
            return addressType.count
        }
        return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if addressTitleTextField.isFirstResponder {
            return addressType[row]
        }
        else {
            return nil
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        addressText.text = addressType[row]
        if addressTitleTextField.isFirstResponder {
            if row != 0 {
                selectedAddressTextView.text = getAddressList[row - 1].A
                
                let itemSelected = addressType[row]
                
                addressTitleTextField.text = itemSelected
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
//    func getAddressFunc() {
//        provider.request(.getAddressList) { [weak self] result in
//            guard self != nil else {return}
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    do {
//                        print(try response.mapJSON())
//
//                        let userResponse = try JSONDecoder().decode(AddressPostResponse.self, from: response.data)
//                        //                        detail = userResponse
//
//                        debugPrint("Mehmet \(userResponse.ResultList![0].A)" )
//                        self!.addressTitleTextField.text = userResponse.ResultList![0].T
//                        self!.addressTextView.text = userResponse.ResultList![0].A //Açık Adres
//                        self!.shortAddressTextView.text = userResponse.ResultList![0].AR //Adres Tarifi
//                        for item in userResponse.ResultList! {
//                            self!.addressType.append(item.T)
//                        }
//                    } catch {
//                        print("Error info: \(error)")
//                    }
//                }
//            case .failure(let error):
//                self!.isLoading(false)
//                print(error.response!)
//            }
//
//        }
//    }
    
}

