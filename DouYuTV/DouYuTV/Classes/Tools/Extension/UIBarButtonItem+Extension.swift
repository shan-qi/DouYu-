//
//  UIBarButtonItem+Extension.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/19.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    convenience init(normalImage:String,highImage:String = "",size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:normalImage), for:.normal)
        if highImage != ""{
            btn.setImage(UIImage(named:highImage), for: .highlighted)
        }
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
}
