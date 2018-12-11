//
//  XQShareView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/15.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQShareView: UIView {
    class func shareView() -> XQShareView{
        return Bundle.main.loadNibNamed("XQShareView", owner: nil, options: nil)?.first as! XQShareView
    }
}
