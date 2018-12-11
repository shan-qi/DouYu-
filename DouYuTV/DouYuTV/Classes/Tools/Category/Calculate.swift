//
//  Calculate.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/4.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

protocol Calculatable {
    // MARK: 计算宽度
    static func collectionViewWidth(_ count: Int) -> CGFloat
    // MARK: 计算高度
    static func collectionViewSmallHeight(_ count: Int) -> CGFloat
    static func collectionViewBigHeight(_ count: Int) -> CGFloat
    static func collectionViewCellSmallHeightSize(_ count: Int) -> CGSize
    static func collectionViewCellBigHeightSize(_ count: Int) -> CGSize
}

extension Calculatable {
    
    
    /// 计算宽度
    static func collectionViewWidth(_ count: Int) -> CGFloat {
        switch count {
        case 1, 2: return (image2Width + 5) * 2
        case 3, 5...9: return xqScreenW - 30
        case 4: return (image3Width + 5) * 2
        default: return 0
        }
        
    }
    
    
    /// 计算高度(宽大于高)
    static func collectionViewSmallHeight(_ count: Int) -> CGFloat {
        switch count {
        case 1: return image1Width / 2
        case 2: return image2Width
        case 3: return image3Width + 5
        case 4...6: return (image3Width + 5) * 2
        case 7...9: return (image3Width + 5) * 3
        default: return 0
        }
    }
    
    //计算高度(高大于宽)
    static func collectionViewBigHeight(_ count: Int) -> CGFloat {
        switch count {
        case 1: return image1Width / 2 + 50
        case 2: return image2Width
        case 3: return image3Width + 5
        case 4...6: return (image3Width + 5) * 2
        case 7...9: return (image3Width + 5) * 3
        default: return 0
        }
    }
    
    
    
    /// 计算 collectionViewCell 的大小 (宽大于高)
    static func collectionViewCellSmallHeightSize(_ count: Int) -> CGSize {
        switch count {
        case  1: return CGSize(width: image1Width , height: image1Width / 2)
        case 2: return CGSize(width: image2Width, height: image2Width)
        case 3...9: return CGSize(width: image3Width, height: image3Width)
        default: return .zero
        }
    }
     /// 计算 collectionViewCell 的大小 (宽小于高)
    static func collectionViewCellBigHeightSize(_ count: Int) -> CGSize {
        switch count {
        case  1: return CGSize(width: image1Width / 2 + 30 , height: image1Width / 2 + 50 )
        case 2: return CGSize(width: image2Width, height: image2Width)
        case 3...9: return CGSize(width: image3Width, height: image3Width)
        default: return .zero
        }
    }
}

struct Calculate: Calculatable {}

