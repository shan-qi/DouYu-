//
//  XQFont.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/8.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

// 常规字体
func FontSize(_ size : CGFloat) -> UIFont {
    
    return UIFont.systemFont(ofSize: AdaptW(size))
}

// 加粗字体
func BoldFontSize(_ size : CGFloat) -> UIFont {
    
    return UIFont.boldSystemFont(ofSize: AdaptW(size))
}
