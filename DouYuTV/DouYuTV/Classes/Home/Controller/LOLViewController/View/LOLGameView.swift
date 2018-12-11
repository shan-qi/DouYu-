//
//  LOLGameView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqGameCellID = "xqGameCellID"
private let xqGameMarin : CGFloat = 10

@objc protocol xqLOLGameViewDelegate {
    //pragma mark: -点击图片回调
    @objc optional func cycleLOLScrollViewDidSelect(at index : Int,cycleScrollView : LOLGameView)
}
class LOLGameView: UIView {
    //定义控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate : xqLOLGameViewDelegate?
    //定义数据属性
    var lols : [ClassifyModel]?{
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
        collectionView.register( UINib(nibName: "BaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqGameCellID)
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
    }
}
//提供一个快速创建View的类方法
extension LOLGameView{
    class func  lolGameView() -> LOLGameView{
        return Bundle.main.loadNibNamed("LOLGameView", owner: nil, options: nil)?.first as! LOLGameView
    }
}
//遵守UICollectionView的数据源协议
extension LOLGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lols?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqGameCellID, for: indexPath) as! BaseCollectionViewCell
        cell.LolModel = lols?[indexPath.item]
        cell.iconTitle.textColor = UIColor.black
        cell.iconTitle.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
}
extension LOLGameView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleLOLScrollViewDidSelect!(at: indexPath.item, cycleScrollView: self)
    }
}

