//
//  XQCategoryItem.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

class XQCategoryItem: XQBaseCollectionViewCell {
    var model : XQRecomCateList?{
        didSet{
            titleLabel.text = model?.cate2_name
            icon.xq_setImage(urlStr: model?.square_icon_url ?? "", placeholder: UIImage(named: "common_classify_placeholder"))
        }
    }
    //图片
    private lazy var icon : UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    //标题
    private lazy var titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = kGrayTextColor
        label.font = FontSize(12)
        label.backgroundColor = kWhite
        label.textAlignment = .center
        return label
    }()
    
    override func xq_initWithView() {
        setUpAllView()
    }
}
extension XQCategoryItem{
    private func setUpAllView(){
        addSubview(icon)
        addSubview(titleLabel)
        
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-10)
            make.left.equalTo(3)
            make.right.equalTo(-3)
        }
    }
}
