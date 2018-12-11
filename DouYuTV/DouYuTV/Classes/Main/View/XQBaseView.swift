//
//  XQBaseView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/13.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

class XQBaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kWhite
        //配置所有子视图
        xq_initWithView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func xq_initWithView(){}
    

}
