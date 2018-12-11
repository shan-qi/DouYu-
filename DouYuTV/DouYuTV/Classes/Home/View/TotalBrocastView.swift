//
//  TotalBrocastView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/29.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class TotalBrocastView: UIView {
    
}
extension TotalBrocastView{
    class func totalBrocastView() -> TotalBrocastView{
        return Bundle.main.loadNibNamed("TotalBrocastView", owner: nil, options: nil)?.first as! TotalBrocastView
    }
}
