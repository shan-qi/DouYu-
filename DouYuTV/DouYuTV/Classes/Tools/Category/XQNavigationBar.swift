//
//  XQNavigationBar.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/22.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isTranslucent = false
        self.barTintColor = UIColor(white: 1, alpha: 0.1)
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setNavigationBar(titleText : NSString,font:UIFont,leftBtn:UIButton,leftImage:UIImage){
        //pragma mark: -设置导航栏标题
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = font
        titleLabel.text = titleText as String
        let attributes = [NSAttributedStringKey.font:font]
        let size = titleText.boundingRect(with:CGSize(width:xqScreenW, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).size
        titleLabel.frame = CGRect(x: (xqScreenW - size.width) / 2, y: (self.height - size.height) / 2 + 10 , width: size.width, height: size.height)
        //pragma mark: -设置导航栏左按钮
        let leftItemView = UIView()
        leftItemView.frame = CGRect(x: 0, y: 20, width: 100, height: 30)
        leftBtn.frame = CGRect(x: -40, y: 0, width: 120, height: 40)
        leftBtn.setTitleColor(UIColor.black, for: .normal)

        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        leftBtn.setImage(leftImage, for: .normal)
        leftItemView.addSubview(leftBtn)
        self.addSubview(titleLabel)
        self.addSubview(leftItemView)
    }
   
    
}
