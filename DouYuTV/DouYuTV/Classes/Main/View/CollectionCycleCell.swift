//
//  CollectionCycleCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/14.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionCycleCell: UICollectionViewCell {
    //1.控件属性
    //1.1背景图片
    @IBOutlet weak var iconImageView: UIImageView!
    //1.2标题
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //2.定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            var imageURL = ""
            if cycleModel?.resource == "" {
                imageURL = cycleModel!.pic_url
            }else{
                imageURL = cycleModel!.resource
            }
            iconImageView.setImage(imageURL, UIImage(named:"Img_default"), false, false, true)
        }
    }
}
