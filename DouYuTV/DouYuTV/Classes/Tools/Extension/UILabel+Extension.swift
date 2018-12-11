//
//  UILabel-Extension.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/12.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

extension UILabel{
    func setLabel(_ label : UILabel){
    
    label.layer.borderColor = UIColor.orange.cgColor
    label.textColor = UIColor.orange
    label.layer.borderWidth = 0.7
    label.layer.cornerRadius = 10
    label.layer.masksToBounds = true
    }
    
    func currentLabel(_ currentLabel : UILabel){
        currentLabel.textColor = UIColor(r: xqSelectedColor.0, g: xqSelectedColor.1, b: xqSelectedColor.2)
        currentLabel.backgroundColor = UIColor(red: 255.0/255, green: 185.0/255, blue: 105.0/255, alpha: 0.5)
        currentLabel.font = UIFont.systemFont(ofSize: 14.0)
        currentLabel.layer.borderWidth = 1
    }
    func oldLabel(_ oldLabel : UILabel){
        oldLabel.textColor = UIColor(r: xqNormalColor.0, g: xqNormalColor.1, b: xqNormalColor.2)
        oldLabel.font = UIFont.systemFont(ofSize: 13.0)
    }
}
