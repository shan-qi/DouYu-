//
//  SettingCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/25.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class SettingCell: UITableViewCell,RegisterCellFromNib {
   
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var subtitleLabelHeight: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var bottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        middleView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }    
}
extension SettingCell{
    //pragma mark: -从沙盒中获取缓存数据的大小
    func calculateDiskCashSize(){
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            //转换成 M
            let sizeM = Double(size) / 1024.0 / 1024.0
            self.rightTitleLabel.text = String(format: "%.2fM",sizeM)
        }
    }
    /// 弹出清理缓存的提示框
    func clearCacheAlertController() {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
            let cache = KingfisherManager.shared.cache
            //清空存储器缓存
            cache.clearMemoryCache()
            //清空磁盘缓存
            cache.clearDiskCache()
            //清空失效和过大的缓存
            cache.cleanExpiredDiskCache()
            self.rightTitleLabel.text = "0.00M"
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
