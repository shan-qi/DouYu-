//
//  XQVerticalButton.swift
//  xqapp
//
//  Created by 单琦 on 2018/5/16.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQVerticalButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView == nil {
            return
        }
        imageView?.frame = CGRect(x: 10, y: 0, width: imageView!.frame.width, height: imageView!.frame.height)
        titleLabel?.frame = CGRect(x: 0, y: imageView!.frame.height, width: frame.width, height: frame.height - imageView!.frame.height)
    }

}
extension XQVerticalButton {
    
    fileprivate func setupUI() {
        titleLabel?.textAlignment = .center
    }
}
