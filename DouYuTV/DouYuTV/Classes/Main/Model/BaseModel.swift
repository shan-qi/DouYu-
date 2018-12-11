//
//  BaseModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/22.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    //pragma mark: -定义属性
    //游戏图标
    @objc  var icon_url : String = ""    
    //分类名字
    @objc var cate_name : String = "推荐分类"
    @objc var cate1_name : String = ""
    @objc var cate2_name : String = ""
    //组显示的图标
    @objc var small_icon_url: String = "yanzhi"
    //王者荣耀名字
    @objc var tag1_name: String = ""
    //王者荣耀图标
    @objc var tag1_icon: String = ""
    //视频推荐名称
    @objc var entry_name : String = ""
    //视频推荐图标
    @objc var entry_icon : String = ""
    
    //重写构造
    override init() {
    }
    //pragma mark: -自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {} 
}
