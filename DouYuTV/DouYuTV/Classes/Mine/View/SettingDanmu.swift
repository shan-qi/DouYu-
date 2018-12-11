//
//  SettingDanmu.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SettingDanmu: UIView {
    
    @IBOutlet weak var topBtn: XQShareButton!
    @IBOutlet weak var allBtn: XQShareButton!
    @IBOutlet weak var bottomBtn: XQShareButton!
    
    
    class func settingDanmu() -> SettingDanmu{
        return Bundle.main.loadNibNamed("SettingDanmu", owner: nil, options: nil)?.first as! SettingDanmu
    }
}
extension SettingDanmu{
    @IBAction func topButtonClicked(_ sender: UIButton) {
        topBtn.setImage(UIImage(named: "btn_danmu_top_selected_set"), for: .normal)
        topBtn.setTitleColor(UIColor.orange, for: .normal)
        
        allBtn.setImage(UIImage(named: "btn_danmu_all_set"), for: .normal)
        allBtn.setTitleColor(UIColor.black, for: .normal)
        
        bottomBtn.setImage(UIImage(named: "btn_danmu_bottom_set"), for: .normal)
        bottomBtn.setTitleColor(UIColor.black, for: .normal)
        
    }
    @IBAction func allButtonClicked(_ sender: UIButton) {
        allBtn.setImage(UIImage(named: "btn_danmu_all_selected_set"), for: .normal)
        allBtn.setTitleColor(UIColor.orange, for: .normal)
        
        topBtn.setImage(UIImage(named: "btn_danmu_top_set"), for: .normal)
        topBtn.setTitleColor(UIColor.black, for: .normal)
        
        bottomBtn.setImage(UIImage(named: "btn_danmu_bottom_set"), for: .normal)
        bottomBtn.setTitleColor(UIColor.black, for: .normal)
        
    }
    @IBAction func bottomButtonClicked(_ sender: UIButton) {
        
        bottomBtn.setImage(UIImage(named: "btn_danmu_bottom_selected_set"), for: .normal)
        bottomBtn.setTitleColor(UIColor.orange, for: .normal)
        
        topBtn.setImage(UIImage(named: "btn_danmu_top_set"), for: .normal)
        topBtn.setTitleColor(UIColor.black, for: .normal)
        
        allBtn.setImage(UIImage(named: "btn_danmu_all_set"), for: .normal)
        allBtn.setTitleColor(UIColor.black, for: .normal)
        
    }
}

