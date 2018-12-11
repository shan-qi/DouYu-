//
//  CollectionRecommendCycleCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/5.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionRecommendCycleCell: UICollectionViewCell {
    //1.控件属性
    //1.2标题
    @IBOutlet weak var titleLabel: UILabel!
    //1.3日期
    @IBOutlet weak var dayTimeLabel: UILabel!
    //1.4预订人数
    @IBOutlet weak var reserveLabel: UILabel!
    
    @IBOutlet weak var normalReserveLabel: UILabel!
    
    @IBOutlet weak var checkLabel: UILabel!
    
    //2.定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            guard let cycleModel = cycleModel else {return}
            titleLabel.text = cycleModel.act_name

            if cycleModel.act_start_time > Int(NSDate.getCurrentTime())!   {
                normalReserveLabel.isHidden = false
                //pragma mark: -预订人数
                var subNum : String = ""
                if cycleModel.sub_num >= 10000{
                    let subnum = Double(cycleModel.sub_num) / 10000.0
                    let sub_num = String(format:"%.1f",subnum)
                    subNum = "\(sub_num)万"
                }else{
                    subNum = "\(cycleModel.sub_num)"
                }
                reserveLabel.text = subNum
                checkLabel.text = "预订"
            }else{
                reserveLabel.text = "进行中"
                checkLabel.text = "查看"
                normalReserveLabel.isHidden = true
            }
            
            //转换为时间
            let timeInterval:TimeInterval = TimeInterval(cycleModel.act_start_time)
            let date = Date(timeIntervalSince1970: timeInterval)            
            //格式话输出
            let dformatter = DateFormatter()
            dformatter.dateFormat = "MM月dd日 HH:mm"
            dayTimeLabel.text = "\(dformatter.string(from: date))开始"
        }
    }

}
