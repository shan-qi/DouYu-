//
//  CycleModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/14.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    //1.链接
    @objc var link : String = ""
    //2.图片资源
    @objc var resource : String = ""
    //3.标题
    @objc var title : String = ""
    //4.图片资源
    @objc var pic_url : String = ""
    //pragma mark: -推荐页面
    //5.标题
    @objc var act_name : String  = ""
    //6.开始时间
    @objc var act_start_time : Int  =  0
    //7.预订
    @objc var sub_num : Int  =  0
    

    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
