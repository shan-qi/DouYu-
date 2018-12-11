//
//  CollectionRecommendReusableView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/5.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionRecommendReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    var anchorClassifyModel : AnchorClassifyModel?{
        didSet{
            guard let anchorClassifyModel = anchorClassifyModel else{return}
            titleLabel.text = anchorClassifyModel.cate_name           
        }
    }
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = self.group?.cate2_name
            iconImageView.setImage(group?.small_icon_url,nil)            
        }
    }
    
}
