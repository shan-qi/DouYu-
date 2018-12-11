//
//  CollectionHeaderReusableView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/22.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    var anchorClassifyModel : AnchorClassifyModel?{
        didSet{
            guard let anchorClassifyModel = anchorClassifyModel else{return}
            titleLabel.text = anchorClassifyModel.cate_name
        }
    }
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = self.group?.cate2_name
        }
    }
    var anchorVideoClassifyModel : AnchorClassifyModel?{
        didSet{
            titleLabel.text = self.anchorVideoClassifyModel?.cate1_name
        }
    }
    
}
