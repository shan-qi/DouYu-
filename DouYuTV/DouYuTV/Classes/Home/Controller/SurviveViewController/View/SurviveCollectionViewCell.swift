//
//  SurviveCollectionViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
private let space = "    "
class SurviveCollectionViewCell: CollectionBaseCell {
    @IBOutlet weak var roomNamelabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tagLabel1: UILabel!
    @IBOutlet weak var tagLabel2: UILabel!
    
    @IBOutlet weak var topRightCornerImageView: UIImageView!
    @IBOutlet weak var topLeftCornerImageView: UIImageView!
    @IBOutlet weak var SurvivalImageView: UIImageView!
    @IBOutlet weak var phoneLiveImageView: UIImageView!
    

    
    override  var anchor : AnchorModel?{
        didSet{
            topLeftCornerImageView.isHidden = true
            topRightCornerImageView.isHidden = true
            phoneLiveImageView.isHidden = true
            SurvivalImageView.isHidden = true
            if anchor?.is_vertical == 1 {
                phoneLiveImageView.isHidden = false
            }
            let icdata = anchor?.icdata
            for icdata_url in icdata!{
                for url in icdata_url{
                    let urlID = url["id"] as? Int
                        if urlID == 225 || urlID == 304 ||
                            urlID == 302{
                            topRightCornerImageView.isHidden = false
                            topRightCornerImageView.setImage(url["url"] as? String)
                        }else{
                            topLeftCornerImageView.isHidden = false
                            phoneLiveImageView.isHidden = true; topLeftCornerImageView.setImage(url["url"] as? String)
                        }
                }
            }
            roomNamelabel.text = anchor?.room_name
            guard let anchorLabel = anchor?.anchor_label else {return}

            if anchor?.cate_id == 270 && (anchor?.rmf1 == 1 || anchor?.rmf3 == 1){
                let element = randomStringFromArray(from: array)
                SurvivalImageView.image = UIImage(named:"\(element)")
                SurvivalImageView.isHidden = false
            }
          
            if anchorLabel.count < 2 {
                tagLabel2.isHidden = true
            }
            guard let anchorFirstLabel = anchorLabel.first else {
                tagLabel1.text = "\(space)暂无标签\(space)"
                tagLabel2.isHidden = true
                return
            }
            tagLabel1.text = "\(space)\(anchorFirstLabel["tag"]!)\(space)"
            for (index,value) in anchorLabel.enumerated(){
                if index == 1{
                    tagLabel2.isHidden = false
                    tagLabel2.text = "\(space)\(value["tag"] ?? "")\(space)"                
                }
                tagLabel1.setLabel(tagLabel1)
                setCustomTagLabel(label: tagLabel1)
                setCustomTagLabel(label: tagLabel2)
            }
            //pragma mark: -对应的普通房间图片
            iconImageView.setImage(anchor?.room_src, UIImage(named:"Img_default"), true)
        }
    }
}
extension SurviveCollectionViewCell{
    func  setCustomTagLabel(label:UILabel){
        label.layer.borderColor = UIColor.orange.cgColor
        label.textColor = UIColor.orange
        label.layer.borderWidth = 0.7
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
    }
}
