//
//  XQShareButton.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/15.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQShareButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame.origin.y = 0
        self.imageView?.center.x = self.frame.width / 2
        self.titleLabel?.center.x = self.frame.width / 2
        self.titleLabel?.frame.origin.y = (self.imageView?.frame.size.height)! + 10
    }
}
