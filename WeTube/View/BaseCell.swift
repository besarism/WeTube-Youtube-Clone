//
//  BaseCell.swift
//  WeTube
//
//  Created by b3 on 12/24/17.
//  Copyright © 2017 b3. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    func setupViews() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
