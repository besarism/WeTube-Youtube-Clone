//
//  MenuBar.swift
//  WeTube
//
//  Created by b3 on 12/24/17.
//  Copyright © 2017 b3. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //Vars:
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1.0)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    let menuItems =  ["home", "trending", "subscriptions", "account"]
    
    
    func setupCollectionView() {
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
        
        let firstMenuItem = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstMenuItem, animated: false, scrollPosition: [])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuCell
        cell.iconImageView.image = UIImage(named: menuItems[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    
    //Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
