//
//  KingCollectionVideoCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/12.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
private let xqKingVideoCellID = "xqKingVideoCellID"
class KingCollectionVideoCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var videoCount: UILabel!
    @IBOutlet weak var KingVideoCollection: UICollectionView!
    @IBOutlet weak var BgImageView: UIImageView!
    var anchor : AnchorModel?{
        didSet{
            guard let chosen = anchor?.chosen else {return}
            bigTitleLabel.text = chosen["omnibus_title"] as? String
            
            guard  let iconURL = URL(string: anchor?.chosen!["omnibus_bg_pic"] as! String) else{return}
            let myChe = ImageCache(name: "my_che")
            BgImageView.kf.setImage(with: iconURL, placeholder:UIImage(named:"Img_default"), options:[.targetCache(myChe)])
            //1.取出观看人数
            var onlineStr : String = ""
            let view_Num  = anchor?.chosen!["view_num"] as! Int
            if view_Num >= 10000 {
                let online = Double(view_Num) / 10000.0
                let online_num = String(format:"%.1f",online)
                onlineStr = "\(online_num)万"
            }else{
                onlineStr = "\(view_Num)"
            }
            videoCount.text = onlineStr
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        KingVideoCollection.register(UINib(nibName: "KingVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqKingVideoCellID)
    }
    override func layoutSubviews() {
        let layout = KingVideoCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: KingVideoCollection.frame.size.width / 2 - 30, height:110)        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let chosen = anchor?.chosen
        let video_list = chosen!["video_list"] as! [[String : Any]]
        return video_list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = KingVideoCollection.dequeueReusableCell(withReuseIdentifier: xqKingVideoCellID, for: indexPath) as! KingVideoCollectionViewCell
        let chosen = anchor?.chosen
        let video_list = chosen!["video_list"] as! [[String : Any]]
        cell.titleLabel.text = video_list[indexPath.item]["video_title"] as? String
        cell.BgImageView.setImage(video_list[indexPath.item]["video_cover"] as? String, UIImage(named:"Img_default"), false, false, false, false, false, true)
        return cell
    }
}
