//
//  SettingSlider.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SettingSlider: UIView {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    
    class func settingSlider() -> SettingSlider{
        return Bundle.main.loadNibNamed("SettingSlider", owner: nil, options: nil)?.first as! SettingSlider
    }
    @IBAction func sliderClicked(_ sender: UISlider) {
        let selectedValue = Int(sender.value)
        sliderValue.text = String(stringInterpolationSegment: "\(selectedValue)%")
        
    }
}
