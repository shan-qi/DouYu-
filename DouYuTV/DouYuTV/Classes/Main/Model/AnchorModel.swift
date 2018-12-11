//
//  AnchorModel.swift
//  DouYu直播
//
//  Created by 单琦 on 2018/1/25.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var isEvenIndex : Bool = false
    //0.直播网址
    var jump_url : String!
    //1.房间ID
    @objc var room_id : NSNumber = 0{
        didSet{
            jump_url = "http://www.douyu.com/\(room_id)"
        }
    }
    //2.房间图片对应的urlString
    //2.1 普通房间图片对应的urlString
   @objc var room_src : String = ""
    //2.2 颜值图片对应的urlString
   @objc var vertical_src : String = ""
    //3.判断时候及直播还是电脑直播
    //3.1 电脑直播->0  手机直播->1
   @objc var is_vertical : Int = 0
    //4.房间名称
   @objc var room_name : String = ""
    //5.主播昵称
   @objc var nickname : String = ""
    //6.观看人数
    @objc var online_num : Int = 0
    //7.主播所在城市
    @objc var anchor_city : String = ""
    //8.游戏种类
    @objc var cate_id : Int = 0
    //9.左上角的状态
    //9.1 有状态->1  无状态->0
    @objc var rmf3 : Int = 0
    //10.左上角连麦PK
    @objc var rmf2 : Int = 0
    //11.左上角抽奖
    @objc var rmf1 : Int = 0
    //12.主播标签
    @objc var anchor_label : [[String : Any]]? = nil
    //13.在线人数
    @objc var online: Int = 0
    //14.是否皇帝推荐
    //14.1 否->0  是->1
    @objc var is_noble_rec : Int = 0
    //15.是否头条主播
    //15.1 否->0  是->1
    @objc var lhl : Int = 0
    //16.视频内容
    @objc var video : [String : NSObject]?
    @objc var chosen : [String : NSObject]?
    //17.视频内容
    @objc var avatar : String  =  ""
    //18.视频日期
    @objc var created_at : String  =  ""
    //19.分类图标名称
    @objc var cate_name : String  =  ""
    //19.视频的分类
    @objc var type : String  =  ""
    
    //左上角的图片
    @objc var icdata : [[[String : Any]]]? 
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        jump_url = "http://www.douyu.com/\(room_id)"
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }   
}
