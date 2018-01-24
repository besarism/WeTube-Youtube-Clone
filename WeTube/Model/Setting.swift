//
//  Setting.swift
//  WeTube
//
//  Created by b3 on 1/14/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit

class Setting: NSObject {
    var name: SettingName
    var icon: String
    
    init(name: SettingName, icon: String) {
        self.name = name
        self.icon = icon
    }
}
