//
//  KingGameView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/11.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqGameCellID = "xqGameCellID"
private let xqGameMarin : CGFloat = 10
@objc protocol xqKingGameViewDelegate {
    //pragma mark: -点击图片回调
    @objc optional func cycleKingScrollViewDidSelect(at index : Int,cycleScrollView : KingGameView)
}
class KingGameView: UIView {
    //定义控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate : xqKingGameViewDelegate?
    //定义数据属性
    var kings : [ClassifyModel]?{
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
extension KingGameView{
    class func  recommendGameView() -> KingGameView{
        return Bundle.main.loadNibNamed("KingGameView", owner: nil, options: nil)?.first as! KingGameView
    }
}
//遵守UICollectionView的数据源协议
extension KingGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kings?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqGameCellID, for: indexPath) as! BaseCollectionViewCell
        cell.kingModel = kings?[indexPath.item]
        cell.iconTitle.textColor = UIColor.black
        cell.iconTitle.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
}
extension KingGameView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleKingScrollViewDidSelect!(at: indexPath.item, cycleScrollView: self)
    }
}
