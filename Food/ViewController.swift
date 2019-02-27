//
//  ViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 18.02.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- For cancelBarButtonItem
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
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

