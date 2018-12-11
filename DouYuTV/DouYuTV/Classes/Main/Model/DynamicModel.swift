//
//  DynamicModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/20.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class DynamicModel: NSObject {
    
    //1.头像
    @objc var avatar : String = ""
    //2.昵称
    @objc var nick_name : String = ""
    //3.性别
    //3.1  1-->男 2-->女
    @objc var sex : Int = 1
    //4.等级
    @objc var dy_level : Int = 0
    //5.日期
    @objc var created_at : String = ""
    //6.阅读量
    @objc var views : Int = 0
    //7.内容
    @objc var content : String = ""
    //8.喜欢的人数
    @objc var likes : Int = 0
    //9.总的评论数
    @objc var total_comments : Int = 0
    //10.转发的人数
    @objc var reposts : Int = 0
    //11.post
    @objc var post : [String : Any]? = nil
    //12.图片
    @objc var imglist : [[String : Any]]? = nil
    //13.奖品
    @objc var prize : [String : Any]? = nil
    //14.视频
    @objc var video : [[String : Any]]? = nil
    //15.热评
    @objc var sub_comments : [[String : Any]]? = nil
    
    
    
    var imageArray : [String] {
        var images : [String] = []
        
        for image in imglist!{
            images.append(image["thumb_url"] as! String)
        }
        return images
    }
    
    var largeImageArray : [String]{
        var images : [String] = []
        
        for image in imglist!{
            images.append(image["url"] as! String)
        }
        return images
    }

    var videoArray : [[String : Any]] {
        let prize = self.prize?.count ?? 0
        var videos : [[String : Any]] = []
        if video?.count != 0{
            let video : [[String : Any]] = self.video!
            videos = video
        }
        if prize == 0 && video?.count == 0 {
            guard let post_video  = post?["video"] as? [[String : Any]] else {return videos}
            videos = post_video
        }
        
        return videos
    }
   
    //显示动态的内容
    var dynamicCellH : CGFloat {
        var  height : CGFloat = 120
        height += titleLabelH
        height += contentLabelH
        if imageArray.count != 0 {
            height += collectionViewH
        }
        if videoArray.count != 0 {
            height += videoCollectionViewH
        }
        if sub_comments?.count != 0 {
            height += sub_commentsH
        }
        return height
    }
    var titleLabelH : CGFloat {
        guard let title = post?["title"] as? String else {
            return 0
        }
        return title.textHeight(fontSize: 16, width: xqScreenW - 30)
        
    }
    
    var contentLabelH : CGFloat {
        //判断内容自定义高度
        let prize = self.prize?.count ?? 0
        
        //判断字符"\n"出现的个数
        var status : [Character : Int] = [:]
        for ch in content{
            let num = status[ch]
            if num != nil
            {
                status[ch] = num! + 1
            }
            else
            {
                status[ch] = 1
            }
        }
        let  staCount = status["\n"] ?? 0
        //内容的高度
        let dynamicContent = content.textHeight(fontSize: 15.0, width: xqScreenW - 30) + 1
        if prize == 12 {
           return dynamicContent
        }else{
            guard let _ = post?["title"] as? String else {
                return dynamicContent
            }
            if staCount >= 2{
                return 53.701171875
            }else{
                if dynamicContent > 71.6015625{
                    return 74.6015625
                }else{
                    return dynamicContent
                }
            }
            
        }
    }
    /// collectionView 图片高度
    var collectionViewH: CGFloat {
        if imageArray.count == 1{
            for image in imglist!{
                let size = image["size"] as! [String:Int]
                let height = size["h"]
                let width = size["w"]
                return height! / width! == 1 ? Calculate.collectionViewBigHeight(imageArray.count) : Calculate.collectionViewSmallHeight(imageArray.count)
            }
        }
        return Calculate.collectionViewSmallHeight(imageArray.count)
    }
    
    ///视频高度
    var videoCollectionViewH : CGFloat = 200
    
    
    var sub_commentsH : CGFloat {
        var height : CGFloat = 0
        var width : CGFloat = 0
        
        for comments in sub_comments!{
            height = (comments["content"] as! String).textHeight(fontSize: 13.0, width: 360)
            width = (comments["nick_name"] as! String).textWidth(fontSize: 13.0, height: height / 2)
            width += (comments["content"] as! String).textWidth(fontSize: 13.0, height: height / 2)
        }
        if height > 31.02734375 || width > 360
        {
            return  31.02734375 + 22
        }
        return height + 27
    }
    


    init(dict : [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

