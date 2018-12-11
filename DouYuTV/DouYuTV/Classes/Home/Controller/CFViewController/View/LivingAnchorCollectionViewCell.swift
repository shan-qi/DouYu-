//
//  LivingAnchorCollectionViewCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class LivingAnchorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var anchor_name: UILabel!
    @IBOutlet weak var anchor_introduce: UILabel!
    
    var anchorModel : ClassifyModel?{
        didSet{
            guard let CFModel = anchorModel else {return}
            anchor_name.text = CFModel.anchor_name
            anchor_introduce.text = CFModel.anchor_introduce
            avatarImageView.setImage(CFModel.avatar, UIImage(named:"allHero"), false,false,false,false,true)
        }
    }
    

}
