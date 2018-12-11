//
//  RecommendViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class RecommendViewCell: UICollectionViewCell {
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var roomNamelabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var SurvivalImageView: UIImageView!
    @IBOutlet weak var lotterImageView: UIImageView!
    @IBOutlet weak var lianmaiPKImageView: UIImageView!
    @IBOutlet weak var guessImageView: UIImageView!
    @IBOutlet weak var phoneLiveImageView: UIImageView!
      var anchor : AnchorModel?{
        didSet{
            phoneLiveImageView.isHidden = true
            guessImageView.isHidden = true
            lianmaiPKImageView.isHidden = true
            lotterImageView.isHidden = true
            SurvivalImageView.isHidden = true
            //0.校验是否有值
            guard let anchor = anchor else{return}
            //1.取出在线人数
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                let online = Double(anchor.online) / 10000.0
                let online_num = String(format:"%.1f",online)
                onlineStr = "\(online_num)万"
            }else{
                onlineStr = "\(anchor.online)"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //2.昵称的显示
            nickName.text = anchor.nickname
            
            if anchor.is_vertical == 1 && anchor.rmf2 == 0 {
                phoneLiveImageView.isHidden = false
            }
            if anchor.rmf3 == 1 && (anchor.cate_id == 1||anchor.cate_id == 124||anchor.cate_id == 3||anchor.cate_id == 331||anchor.cate_id == 181||anchor.cate_id == 2||anchor.cate_id == 40||anchor.cate_id == 349||anchor.cate_id == 55||anchor.cate_id == 113){
                guessImageView.isHidden = false
            }
            if anchor.rmf2 == 1 {
                lianmaiPKImageView.isHidden = false
            }else if anchor.rmf1 == 1{
                phoneLiveImageView.isHidden = true
                lotterImageView.isHidden = false
            }
            if anchor.cate_id == 270 && (anchor.rmf1 == 1 || anchor.rmf3 == 1){
                lotterImageView.isHidden = true
                guessImageView.isHidden = true
                let element = randomStringFromArray(from: array)
                SurvivalImageView.image = UIImage(named:"\(element)")
                SurvivalImageView.isHidden = false
            }
            //pragma mark: -对应的房间名称
            roomNamelabel.text = anchor.room_name
            //pragma mark: -对应的普通房间图片
            iconImageView.setImage(anchor.room_src, UIImage(named:"Img_default"), true)
        }
    }

}
