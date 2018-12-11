//
//  TopSegmentFaceView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/8.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class TopSegmentFaceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let items = ["看热门", "看附近"] as [Any]
        let segmented = UISegmentedControl(items:items)
        segmented.center = center
        segmented.selectedSegmentIndex = 0 //默认选中第二项
        segmented.addTarget(self, action: #selector(segmentDidchange(_:)),
                            for: .valueChanged)  //添加值改变监听
        segmented.frame = CGRect(x: 0, y: 0, width: xqScreenW - 30, height: 30)
        segmented.tintColor = UIColor.orange
        addSubview(segmented)
    }
    @objc func segmentDidchange(_ segmented:UISegmentedControl){
        //获得选项的索引
//        print(segmented.selectedSegmentIndex)
        if segmented.selectedSegmentIndex == 0 {
            
        }
        //获得选择的文字
//        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex) ?? 0)
    }    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

