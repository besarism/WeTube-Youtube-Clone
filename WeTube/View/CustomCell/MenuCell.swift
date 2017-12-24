//
//  MenuCell.swift
//  WeTube
//
//  Created by b3 on 12/24/17.
//  Copyright © 2017 b3. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
    
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            iconImageView.tintColor = isHighlighted ? .white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            iconImageView.tintColor = isSelected ? .white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
        }
    }
    
    override func setupViews() {
        addSubview(iconImageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: iconImageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: NSLayoutAttribute.centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: NSLayoutAttribute.centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
    }
}
