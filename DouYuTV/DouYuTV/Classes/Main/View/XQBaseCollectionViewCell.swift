//
//  XQBaseCollectionViewCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

class XQBaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = kWhite
        xq_initWithView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func xq_initWithView(){}
    
    public class func itemHeight() -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    public class func itemHeightWithModel(model : Any) -> CGSize {
        return CGSize(width: 0.0, height: 0.0)
    }
    
    public class func identifier() -> String {
        
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
        
    }
}
