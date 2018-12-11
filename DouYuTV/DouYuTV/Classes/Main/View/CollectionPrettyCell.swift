//
//  CollectionPrettyCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/8.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {
    @IBOutlet weak var cityName: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var pcOrmobileImageView: UIImageView!
    @IBOutlet weak var cornerImageView: UIImageView!
    @IBOutlet weak var lotterAndGuessImageView: UIImageView!
    
    override  var  anchor: AnchorModel?{
        didSet{
        cornerImageView.isHidden = true
        lotterAndGuessImageView.isHidden = true
            let icdata = anchor?.icdata
            for icdata_url in icdata!{
                for url in icdata_url{
                    let urlID = url["id"] as? String
                    let url_url = url["url"] as? String
                    if urlID == ""{
                       cornerImageView.isHidden = true
                    }else{
                         if url_url == "https://sta-op.douyucdn.cn/dy-listicon/cell-gamble-app-v1.png" || url_url == "https://sta-op.douyucdn.cn/dy-listicon/lottery-app-v1.png"{
                             cornerImageView.isHidden = true
                            lotterAndGuessImageView.isHidden = false
                           lotterAndGuessImageView.setImage(url["url"] as? String)
                         }else{
                            cornerImageView.isHidden = false
                            cornerImageView.setImage(url["url"] as? String)
                        }
                    }
                    
                }
            }
            //为0是手机，为1是电脑
            if anchor?.is_vertical==0 {
                pcOrmobileImageView.image = UIImage(named: "yanzhi_pc_icon")
            }else{
                pcOrmobileImageView.image = UIImage(named: "yanzhi_mobile_icon")
            }
            //pragma mark: -所在的城市
            cityName.setTitle(anchor?.anchor_city, for: .normal)
            //pragma mark: -对应的普通房间图片
            iconImageView.setImage(anchor?.vertical_src, UIImage(named:"live_cell_default_phone"), false, true)
        }
    }
    
}
