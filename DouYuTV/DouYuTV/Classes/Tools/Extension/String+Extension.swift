//
//  String-Extension.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/28.
//  Copyright © 2018年 单琦. All rights reserved.
//

import Foundation

//pragma mark: -抽取随机存活人数
func randomStringFromArray(from array: Array<Any>) -> String {
    let index: Int = Int(arc4random_uniform(UInt32(array.count)))
    return array[index] as! String
}
let array = ["12","21","23","26","29","31","32","33","36","38","40","43","47","51","52","58","60","66","67","70","72","81","83","96","98","决赛圈"]
