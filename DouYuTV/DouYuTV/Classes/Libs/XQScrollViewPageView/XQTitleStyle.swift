//
//  XQTitleStyle.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/29.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQTitleStyle {
    /// 是否是滚动的Title
   public var isScrollEnable : Bool = true
    /// 普通Title颜色
   public var normalColor : UIColor = UIColor(r: 230, g: 230, b: 230)
    /// 选中Title颜色
   public var selectedColor : UIColor = UIColor(r: 255, g: 255, b: 255)
    /// Title字体大小
   public var font : UIFont = UIFont.systemFont(ofSize: 12.0)
    /// 滚动Title的字体间距
   public var titleMargin : CGFloat = 30
    /// titleView的高度
   public var titleHeight : CGFloat = 44
    /// titleView的背景颜色
   public var titleBgColor : UIColor = UIColor.white
    /// titleView的背景渐变色
   public var titleGradColors : [CGColor]? = nil
    /// 是否显示底部滚动条
   public var isShowBottomLine : Bool = true
    /// 底部滚动条的颜色
   public var bottomLineColor : UIColor = UIColor.orange
    /// 底部滚动条的高度
   public var bottomLineH : CGFloat = 2
    
    
    /// 是否进行缩放
   public var isNeedScale : Bool = false
   public var scaleRange : CGFloat = 1.05
    
    
    /// 是否显示遮盖
   public var isShowCover : Bool = false
    /// 遮盖背景颜色
//    255,128,0
   public var coverBgColor : UIColor = UIColor(red: 255/255.0, green: 128/255.0, blue: 0, alpha: 0.2)
    /// 文字&遮盖间隙
   public var coverMargin : CGFloat = 5
    /// 遮盖的高度
   public var coverH : CGFloat = 25
    /// 遮盖的宽度
   public var coverW : CGFloat = 0
    /// 设置圆角大小
   public var coverRadius : CGFloat = 12
}
