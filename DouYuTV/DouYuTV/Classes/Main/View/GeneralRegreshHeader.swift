//
//  GeneralRegreshHeader.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Foundation
import PullToRefreshKit
class GeneralRegreshHeader: UIView,RefreshableHeader {
   let imageView = UIImageView()
   let logoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 60, width: 60, height: 60)
        addSubview(imageView)
        self.backgroundColor = UIColor.white
        logoImage.image = UIImage(named:"img_mj_statePulling")
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "—— 每个人的直播平台 ——"        
        addSubview(logoImage)
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImage.center = CGPoint(x: self.bounds.width/2.0, y: frame.height - 50)
        label.frame = CGRect(x: logoImage.frame.origin.x - 60 , y: logoImage.frame.origin.y + logoImage.frame.height   ,width: 200, height: 20)
        imageView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0 - 20)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - RefreshableHeader
    func heightForHeader() -> CGFloat {
        return 80.0
    }
    //监听百分比变化
    func percentUpdateDuringScrolling(_ percent:CGFloat){
            logoImage.isHidden = false
            label.isHidden = false
    }
    //松手即将刷新的状态
    func didBeginRefreshingState(){
        logoImage.isHidden = true
        label.isHidden = true
        let images = ["img_mj_stateRefreshing_01","img_mj_stateRefreshing_02","img_mj_stateRefreshing_03","img_mj_stateRefreshing_04"].map { (name) -> UIImage in
            return UIImage(named:name)!
        }
        imageView.animationImages = images
        imageView.animationDuration = Double(images.count) * 0.15
        imageView.startAnimating()
        imageView.isHidden = false
    }
    //刷新结束，将要隐藏header
    func didBeginHideAnimation(_ result:RefreshResult){}
    //刷新结束，完全隐藏header
    func didCompleteHideAnimation(_ result:RefreshResult){
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.isHidden = true
    }
}
