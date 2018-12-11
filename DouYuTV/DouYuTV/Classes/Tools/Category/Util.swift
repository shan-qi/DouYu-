//
//  Util.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
