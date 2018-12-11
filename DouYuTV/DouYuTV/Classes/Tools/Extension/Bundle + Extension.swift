//
//  Bundle + Extension.swift
//  app
//
//  Created by 单琦 on 2018/5/13.
//  Copyright © 2018年 单琦. All rights reserved.
//

import Foundation

extension Bundle{
    // 计算型属性  没有参数,有返回值
    var nameSpace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
