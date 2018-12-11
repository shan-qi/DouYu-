//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/9.
//  Copyright © 2018年 单琦. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String{
        //获取当前时间
        let date = NSDate()
        let interval = Int(date.timeIntervalSince1970)
        return "\(interval)"
    }
}
