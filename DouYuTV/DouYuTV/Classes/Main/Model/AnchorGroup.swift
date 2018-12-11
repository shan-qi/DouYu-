//
//  AnchorGroup.swift
//  DouYu直播
//
//  Created by 单琦 on 2018/1/25.
//  Copyright © 2018年 单琦. All rights reserved.
import UIKit

class AnchorGroup: BaseModel {
    //该组中对应的房间信息
    @objc var  list : [[String : NSObject]]?{
        didSet{
         guard  let list = list else {return}
            for dict in list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    @objc var  room_list : [[String : NSObject]]?{
        didSet{
            guard  let list = room_list else {return}
            for dict in list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
     
     lazy var  anchors : [AnchorModel] = [AnchorModel]()
}
