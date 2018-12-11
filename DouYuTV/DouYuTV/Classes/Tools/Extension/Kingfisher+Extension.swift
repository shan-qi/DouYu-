//
//  Kingfisher+Extension.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/13.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView{
    func setImage(_ URLString : String?, _ placeHolderName : UIImage? = nil, _ isNormal: Bool = false,_ isPretty: Bool = false,_ isCyclePicture: Bool = false,_ isVideoPicture: Bool = false,_ isClassifyPicture: Bool = false,_ isVideoBGPicture: Bool = false) {
        guard let URLString = URLString, let url = URL(string: URLString) else {
            // 设置占位图像
            image = placeHolderName
            return
        }        
        kf.setImage(with: url, placeholder: placeHolderName, progressBlock: nil) {[weak self] (image, _, _, _) in
            if isNormal {
                self?.image = image?.reSizeImage(reSize: CGSize(width: xqNormalItemW, height: xqNormalItemH))
            }else if isPretty {
                self?.image = image?.reSizeImage(reSize: CGSize(width: xqNormalItemW, height: xqPrettyItemH))
            }else if isCyclePicture{
                self?.image = image?.reSizeImage(reSize: CGSize(width: xqScreenW, height: xqCycleViewH))
            }else if isVideoPicture{
                self?.image = image?.reSizeImage(reSize: CGSize(width: NormalItemW, height: NormalItemH))
            }else if isClassifyPicture{
                self?.image = image?.reSizeImage(reSize: CGSize(width:185, height: 185))
            }else if isVideoBGPicture{
                self?.image = image?.reSizeImage(reSize: CGSize(width: NormalItemW, height: 300))
            }
        }
    }
}
