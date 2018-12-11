//
//  VideoRecCollectionViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/6/9.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher

class VideoRecCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //pragma mark: -视频推荐模块
    var videoRec : AnchorGroup?{
        didSet{
            guard let anchorGroup = videoRec else {return}
            iconTitle.text = anchorGroup.entry_name
            iconImageView.setImage(anchorGroup.entry_icon,UIImage(named:"btn_rec_more"),false, false, false, false, false, true)
        }
    }
}
