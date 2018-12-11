//
//  KingHeroCollectionReusableView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/14.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class KingHeroCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var heroAnchor : AnchorClassifyModel?{
        didSet{
            titleLabel.text = self.heroAnchor?.tag1_name
            iconImageView.setImage(heroAnchor?.tag1_icon,nil)
        }
    }
    
}
