//
//  StimulateGameView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/25.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqGameCellID = "xqGameCellID"
private let xqGameMarin : CGFloat = 10

@objc protocol xqStimulateGameViewDelegate {
    //pragma mark: -点击图片回调
    @objc optional func cycleStimulateScrollViewDidSelect(at index : Int,cycleScrollView : StimulateGameView)
}
class StimulateGameView: UIView {
    //定义控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate : xqStimulateGameViewDelegate?
    
    //定义数据属性
    var stimulates : [ClassifyModel]?{
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
        collectionView.register( UINib(nibName: "StimulateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqGameCellID)
        //添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 15
    }
}

extension StimulateGameView{
    class func  stimulateGameView() -> StimulateGameView{
        return Bundle.main.loadNibNamed("StimulateGameView", owner: nil, options: nil)?.first as! StimulateGameView
    }
}
//遵守UICollectionView的数据源协议
extension StimulateGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stimulates?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqGameCellID, for: indexPath) as! StimulateCollectionViewCell
        cell.stimulateModel = stimulates?[indexPath.item]
        return cell
    }
}
extension StimulateGameView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleStimulateScrollViewDidSelect!(at: indexPath.item, cycleScrollView: self)
    }
}
