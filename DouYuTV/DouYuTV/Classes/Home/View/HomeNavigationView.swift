//
//  HomeNavigationView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/20.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import IBAnimatable
class HomeNavigationView: UIView,NibLoadable {
    
    @IBOutlet weak var searchButton: AnimatableButton!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    /// 搜索按钮点击
    var didSelectSearchButton: (()->())?
    /// 头像按钮点击
    var didSelectAvatarButton: (()->())?
    /// 二维码按钮点击
    var didSelectScanButton: (()->())?
    /// 历史记录按钮点击
    var didSelectHistoryButton: (()->())?
    /// 消息记录按钮点击
    var didSelectMessageButton: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    /// 固有的大小
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: 44)
        }
    }
    @IBAction func avatorButtonClicked(_ sender: UIButton) {
        didSelectAvatarButton?()
    }
    @IBAction func searchButtonClicked(_ sender: AnimatableButton) {
        didSelectSearchButton?()
    }
    @IBAction func scanButtonClicked(_ sender: UIButton) {
        didSelectScanButton?()
    }
    @IBAction func historyButtonClicked(_ sender: UIButton) {
        didSelectHistoryButton?()
    }
    @IBAction func messageButtonClicked(_ sender: UIButton) {
        didSelectMessageButton?()
    }
    
}
