//
//  XQCALayer.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/9.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
@IBDesignable
extension CALayer{
    var borderColorWithUIColor : UIColor {
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
        set{
            self.borderColor = newValue.cgColor
        }
//
    }
    
}
