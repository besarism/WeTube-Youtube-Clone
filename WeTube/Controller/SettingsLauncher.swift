//
//  SettingsLauncher.swift
//  WeTube
//
//  Created by b3 on 1/12/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //Views
    let menuView = UIView()
    
    let settings: [Setting] = {
        let settingsSetting = Setting(name: .settings, icon: "settings")
        let privacySetting = Setting(name: .privacy, icon: "privacy")
        let feedbackSetting = Setting(name: .feedback, icon: "feedback")
        let helpSetting = Setting(name: .help, icon: "help")
        let switchaccount = Setting(name: .switchaccount, icon: "switch_account")
        let cancelSetting = Setting(name: .cancel, icon: "cancel")
        
        
        return [settingsSetting, privacySetting, feedbackSetting, helpSetting, switchaccount, cancelSetting]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    var homeController: HomeController?
    
    
    func showSettings() {
        print("More")
        //Access the whole window to get it's frames
        if let window = UIApplication.shared.keyWindow {
            menuView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            self.menuView.backgroundColor  = UIColor(white: 0, alpha: 0.5)
            window.addSubview(menuView)
            window.addSubview(collectionView)
            
            self.menuView.frame = window.frame
            self.menuView.alpha = 0
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.menuView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }, completion: nil)
            
        }
        
    }
    
    @objc func handleDismiss(setting:Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if let window = UIApplication.shared.keyWindow {
                self.menuView.alpha = 0
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            if setting.name != .cancel {
                self.homeController?.showController(For: setting)
            }
        }
    }
    
    
   
    //CollectionView methods:
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    
    
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}


enum SettingName: String {
    case settings = "Settings"
    case privacy = "Terms & privacy policy"
    case feedback = "Send Feedback"
    case help = "Help"
    case switchaccount = "Switch Account"
    case cancel = "Cancel"
}



