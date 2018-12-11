//
//  KingHeroCollectionViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/14.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class KingHeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconTitle: UILabel!
    @IBOutlet weak var liveCountLabel: UILabel!
    
    var kingModel : ClassifyModel?{
        didSet{
            guard let kingModel = kingModel else{return}
            iconTitle.text = kingModel.tag2_name
            liveCountLabel.text = "\(kingModel.room_count)场直播"
            iconImageView.setImage(kingModel.tag2_icon, UIImage(named:"allHero"), false,false,false,false,true)
        }
    }

}
