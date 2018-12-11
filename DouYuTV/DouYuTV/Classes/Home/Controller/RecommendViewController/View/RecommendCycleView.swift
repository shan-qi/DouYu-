//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/5.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqCycleCellID = "xqCycleCellID"

@objc protocol xqRecommendCycleViewDelegate {
    //pragma mark: -点击图片回调
    @objc optional func cycleRecommendScrollViewDidSelect(cycleScrollView : RecommendCycleView)
}
class RecommendCycleView: UIView {
    //定义定时器
    var cycleTimer : Timer?
    weak var delegate : xqRecommendCycleViewDelegate?
    var cycleModels : [CycleModel]?{
        didSet{
            //1.刷新collectionView
            collectionView.reloadData()
            //3.默认滚动到中间的一个位置
            let  indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at:indexPath,at:.top, animated: false)
            //4.删除定时器
            removeCycleTimer()
            
            if (cycleModels?.count)! > 1 {
                //5.获取定时器
                addCycleTimer()
            }
            
        }
    }
    //定义控件
    @IBOutlet weak var collectionView: UICollectionView!
    
    //系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册collectionView
        collectionView.register( UINib(nibName: "CollectionRecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: xqCycleCellID)
        collectionView.backgroundColor = UIColor.white
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
//提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
//遵守UICollectionViewDataSource的数据源
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqCycleCellID, for: indexPath) as! CollectionRecommendCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}
//遵守UICollectionViewDelegate的数据源
extension RecommendCycleView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleRecommendScrollViewDidSelect!(cycleScrollView: self)
    }
    
}
//对定时器的操作方法
extension RecommendCycleView{
    //添加定时器
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 2, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    //移除定时器
    private func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    //滚动到下一个定时器
    @objc private func scrollToNext(){
        //获取滚动的偏移量
        let currentoffsetY = collectionView.contentOffset.y
        let offsetY = currentoffsetY + collectionView.bounds.height
        //滚动到那个位置
        collectionView.setContentOffset(CGPoint(x:0,y:offsetY), animated: true)
    }

}
