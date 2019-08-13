//
//  SettingsViewController.swift
//  Food
//
//  Created by Ali Emre Değirmenci on 8.03.2019.
//  Copyright © 2019 Ali Emre Değirmenci. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UITableViewController {
    
    let settingList = ["Bilgilerim", "Önceki Siparişlerim", "Favorilerim", "Adreslerim", "Çıkış Yap"]
    let identities = ["MyInfos", "MyPastOrders", "MyFavorites", "MyAddresses", "Logout"]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherList")
        
        let list = settingList[indexPath.row]
        
        cell?.textLabel?.text = list
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            let alert = UIAlertController.init(title: "Çıkış Yap", message: "Çıkış yapmak istediğinize emin misiniz?", preferredStyle: .alert)
            
            let noAct = UIAlertAction(title: "Hayır", style: .default) { alertAction in
                alert.dismiss(animated: true)
            }
            let yesAct = UIAlertAction(title: "Evet", style: .default) { alertAction in
                //MARK: Userdefaults delete all
                let defaults = UserDefaults.standard
                let dictionary = defaults.dictionaryRepresentation()
                dictionary.keys.forEach { key in
                    defaults.removeObject(forKey: key)
                }
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "settingsToIntro", sender: nil)
            }
            
            alert.addAction(noAct)
            alert.addAction(yesAct)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let vcNames = identities[indexPath.row]
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcNames)
            self.show(viewController!, sender: nil)
        }
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
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
