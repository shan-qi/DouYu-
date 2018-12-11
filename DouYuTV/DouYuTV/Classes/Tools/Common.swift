//
//  Common.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit


let app_ver : String = "4910000"

// 判断是否为 iPhone X
let isIphoneX = xqScreenH >= 812 ? true : false

let xqStatusBarH  : CGFloat = isIphoneX ? 44 : 20

let xqNavigationH : CGFloat = 44
//pragma mark: -底部tabBar
let xqBarbarH : CGFloat = 44

// 隐藏导航栏
let kNavBarHidden : [String:String] = ["isHidden":"true"]
// 显示 导航栏
let kNavBarNotHidden : [String:String] = ["isHidden":"false"]

//pragma mark: -屏幕高
let xqScreenH = UIScreen.main.bounds.height
//pragma mark: -屏幕宽
let xqScreenW = UIScreen.main.bounds.width

let CateItemHeight = xqScreenW / 4


//当前版本，类型转换，要找对正确类型，然后执行此类型下的方法
let Device_System:CGFloat = CGFloat((UIDevice.current.systemVersion as NSString).floatValue)
//导航高
let Navi_Height:CGFloat = 44

//pragma mark: -滚动条里面首先显示的数目
let xqLabelItem : CGFloat = 4

//pragma mark: -颜色
let xqNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
let xqSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

let xqDownTitleViewH : CGFloat = 150
let xqTitleViewH : CGFloat = 40
let xqCycleViewH : CGFloat = (xqScreenW * 3) / 8
let xqCateTitleH : CGFloat = 42
// 宽度比
let kWidthRatio = xqScreenW / 375.0
// 高度比
let kHeightRatio = xqScreenH / 667.0

let xqNormalCellID = "xqNormalCellID"
let xqSurviveCellID = "xqSurviveCellID"
let xqPrettyCellID = "xqPrettyCellID"
let xqHeaderViewID = "xqHeaderViewID"
let xqRecommendCellID = "xqRecommendCellID"
let DynamicCellID = "DynamicCellID"

let XQNotiRefreshHomeNavBar : String = "XQNotiRefreshHomeNavBar"


let xqItemMargin : CGFloat  = 10
let NormalItemW : CGFloat = xqScreenW
let NormalItemH : CGFloat = 250


/// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = (xqScreenW-40) * 2 / 3
let image2Width: CGFloat = (xqScreenW - 35) / 2
let image3Width: CGFloat = (xqScreenW - 40) / 3

let XQSelectTabberNotification = Notification.Name(rawValue: "XQSelectTabberNotification")


// 自适应
func Adapt(_ value : CGFloat) -> CGFloat {
    
    return AdaptW(value)
}

// 自适应宽度
func AdaptW(_ value : CGFloat) -> CGFloat {
    
    return ceil(value) * kWidthRatio
}

// 自适应高度
func AdaptH(_ value : CGFloat) -> CGFloat {
    
    return ceil(value) * kHeightRatio
}

func xq_setUpGradientLayer(view:UIView,frame:CGRect,color:[CGColor],corneradius:CGFloat? = 0){
    let grandientLayer : CAGradientLayer = CAGradientLayer()
    grandientLayer.colors = color
    grandientLayer.startPoint = CGPoint(x: 0, y: 0)
    grandientLayer.endPoint = CGPoint(x: 1, y: 0)
    
    grandientLayer.frame = frame
    grandientLayer.cornerRadius = corneradius!
    view.layer.insertSublayer(grandientLayer, at: 0)
    
}

func getloadingImages() -> [UIImage]{
    var loadingImages = [UIImage]()
    for index in 0...14{
        let loadImageName = String(format: "dyla_img_loading_%03d",index)
        if let loadImage = UIImage(named: loadImageName){
            loadingImages.append(loadImage)
        }
    }
    return loadingImages
}
