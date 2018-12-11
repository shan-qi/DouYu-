//
//  DynamicCollectionViewVideoCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/4.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class DynamicCollectionViewVideoCell: UICollectionViewCell,RegisterCellFromNib {
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var playCount: UILabel!
    @IBOutlet weak var playTime: UILabel!
    
    
    var thumb_video : [String : Any]?{
        didSet{
            videoImageView.kf.setImage(with: URL(string:thumb_video!["thumb"] as! String))
            let videoCount  = thumb_video!["view_num"] as? String
            if videoCount == "0"{
                playCount.isHidden = true
            }else{
                //1.取出在线人数
                if Int(videoCount ?? "")! >= 10000 {
                    let online = Double((videoCount ?? ""))! / 10000.0
                    let online_num = String(format:"%.1f",online)
                    playCount.text = "\(online_num)万次播放"
                }else{
                    playCount.text = "\(videoCount ?? "")次播放"
                }
            }
            playTime.text = thumb_video!["video_str_duration"] as? String
        }
    }
    
    
    

}
