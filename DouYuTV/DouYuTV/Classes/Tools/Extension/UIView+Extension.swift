//
//  UIView+Catrgory.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/16.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import SnapKit
extension UIView {
    
    public func isShowingOnKeyWindow() -> Bool {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return false
        }
        
        // 以主窗口的左上角为原点，计算self的矩形框
        let newFrame = keyWindow.convert(self.frame, from: self.superview)
        let windowBounds = keyWindow.bounds
        
        // 主窗口的bounds和self的矩形框是否有重叠
        let isIntersects = newFrame.intersects(windowBounds)
        
        return isIntersects && (self.isHidden == false) && (self.alpha > 0.01) && (self.window == keyWindow)
    }
    /// 快速创建 View 并使用 SnapKit 布局
    ///
    /// - Parameters:
    ///   - bgClor: View 的背景颜色
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  View
    class func xq_createView(bgClor : UIColor , supView : UIView? ,closure:(_ make:ConstraintMaker) ->()) -> UIView {
        let view = UIView()
        view.backgroundColor = bgClor
        if supView != nil {
            supView?.addSubview(view)
            view.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return view
    }
    /// 快速创建一个 UIImageView,可以设置 imageName,contentMode,父视图,约束
    ///
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - contentMode: 填充模式
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  UIImageView
    class func xq_createImageView(imageName : String? , contentMode : UIViewContentMode? = nil,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UIImageView {
        
        let imageV = UIImageView()
        
        if imageName != nil {
            imageV.image = UIImage(named: imageName!)
        }
        
        if contentMode != nil {
            imageV.contentMode = contentMode!
        }
        
        if supView != nil {
            supView?.addSubview(imageV)
            imageV.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return imageV
    }
    
    
    /// 快速创建 UIButton,设置标题,图片,父视图,约束
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - titleStatu: 标题状态模式
    ///   - imageName: 图片名
    ///   - imageStatu: 图片状态模式
    ///   - supView: 父视图
    ///   - closure: 约束
    /// - Returns:  UIButton
    class func xq_createButton(title : String?,titleStatu : UIControlState?,titleColor: UIColor? = nil,imageName : String?,imageStatu : UIControlState?, font : UIFont? = FontSize(14),supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UIButton{
        let btn = UIButton()
        
        if title != nil {
            btn.setTitle(title, for: .normal)
        }
        
        if title != nil && titleStatu != nil {
            btn.setTitle(title, for: titleStatu!)
        }
        
        if imageName != nil {
            btn.setImage(UIImage(named: imageName!), for: .normal)
        }
        
        if imageName != nil && imageStatu != nil {
            btn.setImage(UIImage(named: imageName!), for: imageStatu!)
        }
        
        if titleColor != nil {
            btn.setTitleColor(titleColor, for: .normal)
        }
        btn.titleLabel?.font = font
        if supView != nil {
            supView?.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return btn
    }
    
    
    /// 快速创建 Label,设置文本, 文本颜色,Font,文本位置,父视图,约束
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - font: 字体大小
    ///   - textAlignment: 文本位置
    ///   - supView: 父视图
    ///   - closure: 越是
    /// - Returns:  UILabel
    class func xq_createLabel(text : String? , textColor : UIColor?, font : UIFont?, textAlignment : NSTextAlignment = .left,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UILabel {
        
        let label = UILabel()
        label.text = text
        if (textColor != nil) { label.textColor = textColor }
        if (font != nil) { label.font = font }
        label.textAlignment = textAlignment
        
        if supView != nil {
            supView?.addSubview(label)
            label.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return label
    }
    
    
    /// 快速创建 UITextField,设置文本,文本颜色,placeholder,字体大小,文本位置,边框样式, 自动布局
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - placeholder: placeholder
    ///   - font: 字体大小
    ///   - textAlignment: 文本位置
    ///   - borderStyle: 边框样式
    ///   - supView: 父视图
    ///   - closure:  make
    /// - Returns: UITextField
    class func xq_createTextField(text : String? , textColor : UIColor?, placeholder: String, font : UIFont?, textAlignment : NSTextAlignment = .left, borderStyle :UITextBorderStyle = .none,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UITextField {
        
        let textField = UITextField()
        textField.text = text
        textField.placeholder = placeholder
        textField.borderStyle = borderStyle
        if (textColor != nil) { textField.textColor = textColor }
        if (font != nil) { textField.font = font }
        
        textField.textAlignment = textAlignment
        
        if supView != nil {
            supView?.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return textField
    }
    
}
