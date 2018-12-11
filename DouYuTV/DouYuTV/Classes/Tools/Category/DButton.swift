//
//  DButton.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/9.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
@IBDesignable
class DButton: UIButton {
    //  设置圆角
    @IBInspectable var dCornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = dCornerRadius
            //  这行代码和控件阴影冲突，如果设置了圆角。便不能在设置阴影
            layer.masksToBounds = (dCornerRadius > 0)
        }
    }
    
    //  设置边框宽度
    @IBInspectable var dBorderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = dBorderWidth > 0 ? dBorderWidth : 0
        }
    }
    
    //  设置边框颜色
    @IBInspectable var dBorderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = dBorderColor.cgColor
        }
    }
}
