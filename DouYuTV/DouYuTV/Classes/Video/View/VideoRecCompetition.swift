//
//  VideoRecCompetition.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/6/9.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqCompetionCellID = "xqCompetionCellID"
private let xqGameMarin : CGFloat = 0
class VideoRecCompetition: UIView {
    //定义控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    //定义数据属性
    var anchorGroups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    //系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //1.子空间不随父控件的拉伸而改变
        autoresizingMask = UIViewAutoresizing()
        //2.注册Cell
        collectionView.register( UINib(nibName: "VideoRecCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqCompetionCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize
        layout.minimumLineSpacing = 20
    }
}
//提供一个快速创建View的类方法
extension VideoRecCompetition{
    class func  videoRecCompetition() -> VideoRecCompetition{
        return Bundle.main.loadNibNamed("VideoRecCompetition", owner: nil, options: nil)?.first as! VideoRecCompetition
    }
}
//遵守UICollectionView的数据源协议
extension VideoRecCompetition : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqCompetionCellID, for: indexPath) as! VideoRecCollectionViewCell
        cell.videoRec = anchorGroups?[indexPath.item]
        return cell
    }
}

