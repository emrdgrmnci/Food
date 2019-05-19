//
//  ViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 18.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    //MARK:- For cancelBarButtonItem
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    @IBAction func showWebPage(_ sender: Any) {
        
    showWebPage()
    }
    
    func showWebPage() {
        if let url = URL(string: "http://mehmetguner.pryazilim.com") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
            vc.preferredBarTintColor = .red
            vc.preferredControlTintColor = .white
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

