//
//  CollectionVideoCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/17.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var BigTitle: UILabel!
    @IBOutlet weak var brocastNum: UILabel!
    @IBOutlet weak var labelTag: UILabel!    
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var videoUpNum: UIButton!
    @IBOutlet weak var barrageNum: UIButton!
    
    var anchor : AnchorModel?{
        didSet{
            guard let anchorVideo = anchor?.video else {return}
           backGroundImageView.setImage(anchorVideo["video_cover"] as? String, nil, false, false, false, true)
            
            faceImageView.setImage(anchorVideo["owner_avatar"] as? String, nil, false, false, false)

            BigTitle.text = anchorVideo["video_title"] as? String
            labelTag.text = " • \(anchorVideo["cate2_name"] as? String ?? "") "
            var brocastStr : String = ""
            guard let brocast_Num = anchorVideo["view_num"] as? Int else{return}
            if brocast_Num >= 10000 {
                let brocast = Double(brocast_Num) / 10000.0
                let brocast_num = String(format:"%.1f",brocast)
                brocastStr = "\(brocast_num)万次播放"
            }else{
                brocastStr = "\(brocast_Num)次播放"
            }
            brocastNum.text = brocastStr
            
            
            duration.text = anchorVideo["video_str_duration"] as? String
            nickname.text = anchorVideo["nickname"] as? String
            
            var upNumStr : String = ""
            guard let upCount = anchorVideo["video_up_num"] as? Int else {return}
            if upCount >= 10000 {
                let count = Double(upCount) / 10000.0
                let upNum_Count = String(format: "%.1f", count)
                upNumStr = "\(upNum_Count)万次播放"
            }else{
                upNumStr = "\(upCount)次播放"
            }
            videoUpNum.setTitle(upNumStr, for: .normal)
            guard let barrage_Num = anchorVideo["barrage_num"] as? Int else{return}
            if barrage_Num == 0 {
                barrageNum.setTitle("弹幕", for: .normal)
            }else{
                barrageNum.setTitle("\(barrage_Num)", for: .normal)
            }
            
        }
    }
}
