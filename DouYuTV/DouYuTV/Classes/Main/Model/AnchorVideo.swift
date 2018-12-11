//
//  AnchorVideo.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/18.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class AnchorVideo: NSObject {
    //1.主播昵称
    @objc var nickname : String = ""
    //2. 视频时长
    @objc var video_str_duration : String = ""
    //3. 圆形头像
    @objc var owner_avatar : String = ""
    //4. 视频播放次数
    @objc var view_num : String = ""
    //5. 视频封面
    @objc var video_cover : String = ""
    //6. 评论次数
    @objc var barrage_num : Int = 0
    //7. 点赞次数
    @objc var video_up_num : Int = 0
    //8. 视频大标题
    @objc var video_title : String = ""
    
    init(dict : [String:Any]) {
        super.init()
         setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
