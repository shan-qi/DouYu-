//
//  XQSwitch.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/25.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQSwitch: UISwitch {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.tintColor = UIColor.init(hex: "#f6f6f6", alpha: 1.0)
        self.onTintColor = UIColor.orange
    }

}
