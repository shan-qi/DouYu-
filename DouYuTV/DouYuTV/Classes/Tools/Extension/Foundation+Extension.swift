//
//  Foundation+Extension.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/2.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

extension String {
    /// 计算文本的高度
    func textHeight(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
    /// 计算文本的宽度
    func textWidth(fontSize: CGFloat, height: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.width
    }
    
}
