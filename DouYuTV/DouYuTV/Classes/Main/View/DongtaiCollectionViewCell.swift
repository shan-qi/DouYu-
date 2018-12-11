//
//  DongtaiCollectionViewCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD
class DongtaiCollectionViewCell: UICollectionViewCell,RegisterCellFromNib {
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var thumbImage : String?{
        didSet{
            thumbImageView.kf.setImage(with: URL(string:thumbImage!))
        }        
    }
    var largeImage : String?{
        didSet{
            thumbImageView.kf.setImage(with: URL(string: largeImage!), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                let progress = Float(receivedSize) / Float(totalSize)
                SVProgressHUD.showProgress(progress)
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(UIColor.white)
            }) { (image, error, cacheType, url) in
                SVProgressHUD.dismiss()
            }
        }
    }
}
