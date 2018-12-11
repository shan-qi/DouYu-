//
//  ClassifyModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class ClassifyModel: BaseModel {
    //1.图标
    @objc var square_icon_url : String = ""
    //2.图标以及名称
    @objc var tag2_icon : String  =  ""
    @objc var tag2_name : String  =  ""
    //3.直播数量
    @objc var room_count : Int  =  0
    @objc var mobile_icon2 : String  =  ""
    //4.主播在线
    //介绍
    @objc var anchor_introduce : String  =  ""
    //名字
    @objc var anchor_name : String  =  ""
    //头像
    @objc var avatar : String  =  ""
}
