//
//  SettingCell.swift
//  WeTube
//
//  Created by b3 on 1/13/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            if let name = setting?.name.rawValue {
                nameLabel.text = name
            }
            if let iconName = setting?.icon {
                let image = UIImage(named: iconName)
                icon.image = image?.withRenderingMode(.alwaysTemplate)
                icon.tintColor = .darkGray
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white: .black
            icon.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    let icon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "settings"))
        
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(icon)
        addSubview(nameLabel)
        
        //Horizontal Constraints:
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-16-[v1]|", views: icon, nameLabel)
        
        //Vertical:
        addConstraintsWithFormat(format: "V:[v0(30)]", views: icon)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
