//
//  CollectionNormalCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionNormalCell: CollectionBaseCell {
  
    @IBOutlet weak var roomNamelabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var topLeftCornerImageView: UIImageView!
    @IBOutlet weak var topRightCornerImageView: UIImageView!
    @IBOutlet weak var phoneLiveImageView: UIImageView!
    override  var anchor : AnchorModel?{
        didSet{
            
            phoneLiveImageView.isHidden = true
            topLeftCornerImageView.isHidden = true
            topRightCornerImageView.isHidden = true
            
            if anchor?.is_vertical == 1 {
                phoneLiveImageView.isHidden = false
            }
            
            //pragma mark: -对应的房间名称
            roomNamelabel.text = anchor?.room_name
            //pragma mark: -对应的普通房间图片
            iconImageView.setImage(anchor?.room_src, UIImage(named:"Img_default"), true, false, false)            
            guard let icdata = anchor?.icdata else {return}
            for icdata_url in icdata{
                for url in icdata_url{
                    let urlID = url["id"] as? Int
                        if urlID == 225 || urlID == 302 || urlID == 304{
                            topRightCornerImageView.isHidden = false
                            topRightCornerImageView.setImage(url["url"] as? String)
                        }else{
                            topLeftCornerImageView.isHidden = false
                            phoneLiveImageView.isHidden = true; topLeftCornerImageView.setImage(url["url"] as? String)
                    }
                }
            }
            //pragma mark: -对应的房间名称
            roomNamelabel.text = anchor?.room_name
            //pragma mark: -对应的普通房间图片
            iconImageView.setImage(anchor?.room_src, UIImage(named:"Img_default"), true, false, false)
        }
    }
    
}
