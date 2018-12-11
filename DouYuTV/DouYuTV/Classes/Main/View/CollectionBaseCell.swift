//
//  CollectionBaseCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickName: UILabel!
    
    var anchor : AnchorModel?{
        didSet{
            //0.校验是否有值
            guard let anchor = anchor else{return}
            //1.取出在线人数
            var onlineStr : String = ""
            if anchor.online_num >= 10000 {                
                let online = Double(anchor.online_num) / 10000.0
                let online_num = String(format:"%.1f",online)
                onlineStr = "\(online_num)万"
            }else{
                onlineStr = "\(anchor.online_num)"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //2.昵称的显示
            nickName.text = anchor.nickname            
        }
    }
}
