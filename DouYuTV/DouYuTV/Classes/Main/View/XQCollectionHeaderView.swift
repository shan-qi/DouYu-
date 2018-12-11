//
//  XQCollectionHeaderView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/14.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

class XQCollectionHeaderView: UICollectionReusableView {
    lazy var titleLab = UILabel()
    lazy var topLine : UIView = UIView()
    lazy var bottomLine : UIView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = kWhite
    }
    
    func configTitle(title : String){
        titleLab.text = title
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension XQCollectionHeaderView {
    func setupView(){
        topLine = UIView.xq_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(0.6)
        })
        titleLab = UILabel.xq_createLabel(text: "", textColor: kMainTextColor, font:BoldFontSize(16), supView: self, closure: { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(AdaptW(15))
        })
        bottomLine = UIView.xq_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(0.6)
        })
    }
}
