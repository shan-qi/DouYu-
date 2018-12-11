//
//  CFAnchorView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqAnchorCellID = "xqAnchorCellID"
private let xqGameMarin : CGFloat = 10
class CFAnchorView: UIView {
    //定义控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //定义数据属性
    var cfs : [ClassifyModel]?{
        didSet{
            //刷新数据
            collectionView.reloadData()
        }
    }
    //系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //1.子空间不随父控件的拉伸而改变
        autoresizingMask = UIViewAutoresizing()
        //2.注册Cell
        collectionView.register( UINib(nibName: "LivingAnchorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqAnchorCellID)
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
    }
}
//提供一个快速创建View的类方法
extension CFAnchorView{
    class func  recommendGameView() -> CFAnchorView{
        return Bundle.main.loadNibNamed("CFAnchorView", owner: nil, options: nil)?.first as! CFAnchorView
    }
}
//遵守UICollectionView的数据源协议
extension CFAnchorView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cfs?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqAnchorCellID, for: indexPath) as! LivingAnchorCollectionViewCell
        cell.anchorModel = cfs?[indexPath.item]
        return cell
    }
}

