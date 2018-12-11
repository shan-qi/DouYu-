//
//  RecommendGameView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/6.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqGameCellID = "xqGameCellID"
private let xqGameMarin : CGFloat = 0
@objc protocol xqRecommendGameViewDelegate {
    //pragma mark: -点击图片回调
    @objc optional func cycleRecommendScrollViewDidSelect(at index : Int,cycleScrollView : RecommendGameView)
}
class RecommendGameView: UIView {
    //定义控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate : xqRecommendGameViewDelegate?
    //定义数据属性
    var classifys : [ClassifyModel]?{
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: xqGameMarin, bottom: 0, right: xqGameMarin)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 20
    }
}
//提供一个快速创建View的类方法
extension RecommendGameView{
    class func  recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
//遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classifys?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqGameCellID, for: indexPath) as! BaseCollectionViewCell
        cell.classifyModel = classifys?[indexPath.item]
        return cell
    }
}
extension RecommendGameView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleRecommendScrollViewDidSelect!(at: indexPath.item, cycleScrollView: self)
    }
}
