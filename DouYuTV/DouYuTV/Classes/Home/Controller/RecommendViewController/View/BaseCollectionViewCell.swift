//
//  BaseCollectionViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/23.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconTitle: UILabel!
    
    var classifyModel : ClassifyModel?{
        didSet{
            guard let classifyModel = classifyModel else{return}
            iconTitle.text = classifyModel.cate2_name
            iconImageView.setImage(classifyModel.square_icon_url,
                                   UIImage(named:"common_classify_placeholder"),
                                   false,false,false,false,true)
            if classifyModel.cate2_name == "更多" {
                iconImageView.image = UIImage(named: "btn_rec_more");
            }

        }
    }
    var kingModel : ClassifyModel?{
        didSet{
            guard let classifyModel = kingModel else{return}
            iconTitle.text = classifyModel.tag2_name
            iconImageView.setImage(classifyModel.tag2_icon, UIImage(named:"allHero"), false,false,false,false,true)
        }
    }
    
    var LolModel : ClassifyModel?{
        didSet{
            guard let classifyModel = LolModel else{return}
            iconTitle.text = classifyModel.tag2_name
            iconImageView.setImage(classifyModel.tag2_icon, UIImage(named:"lol_icon_allBg"), false,false,false,false,true)
        }
    }
    
    
    var stimulateModel : ClassifyModel?{
        didSet{
            guard let classifyModel = stimulateModel else {return}
            iconTitle.isHidden = true
            iconImageView.setImage(classifyModel.tag2_icon, UIImage(named:"allHero"), false,false,false,false,true)
        }
    }
    
    var classifyVideoModel : ClassifyModel?{
        didSet{
            guard let classifyModel = classifyVideoModel else{return}
            iconTitle.text = classifyModel.cate2_name
            iconImageView.setImage(classifyModel.mobile_icon2,UIImage(named:"btn_rec_more"),false,false,false,false,true)
        }
    }
    
    
}


