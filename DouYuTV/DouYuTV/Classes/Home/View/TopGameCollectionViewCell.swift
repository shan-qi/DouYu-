//
//  TopGameCollectionViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class TopGameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pcGameLabel: UILabel!
    
    var onlineModel : ClassifyModel?{
        didSet{
            guard let onlineModel = onlineModel else{return}
            pcGameLabel.text = onlineModel.cate2_name
        }
    }
}
