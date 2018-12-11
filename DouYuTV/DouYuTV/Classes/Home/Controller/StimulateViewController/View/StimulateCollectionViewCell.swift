//
//  StimulateCollectionViewCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class StimulateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    var stimulateModel : ClassifyModel?{
        didSet{
            guard let classifyModel = stimulateModel else {return}
            iconImageView.setImage(classifyModel.tag2_icon, UIImage(named:"allGuns"), false,false,false,false,false)
        }
    }

}
