//
//  StimulateAllGunsCollectionViewCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class StimulateAllGunsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var liveCountLabel: UILabel!
    
    var stimulateModel : ClassifyModel?{
        didSet{
            guard let stimulateModel = stimulateModel else{return}
            liveCountLabel.text = "\(stimulateModel.room_count)场直播"
            iconImageView.setImage(stimulateModel.tag2_icon, UIImage(named:"allHero"), false,false,false,false,false)
        }
    }

}
