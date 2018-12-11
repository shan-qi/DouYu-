//
//  GeneralCycleView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/14.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

@objc protocol xqGeneralCycleViewDelegate {
   //pragma mark: -点击图片回调
   @objc optional func cycleScrollViewDidSelect(at index : Int,cycleScrollView : GeneralCycleView)
}

private let xqCycleCellID = "xqCycleCellID"
class GeneralCycleView: UIView {

    //定义定时器
    var cycleTimer : Timer?
    weak var delegate : xqGeneralCycleViewDelegate?
    var cycleModels : [CycleModel]?{
        didSet{
            //1.刷新collectionView
            collectionView.reloadData()
            //2.获取pageContrl的个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            if cycleModels?.count == 1 {
                pageControl.isHidden = true
                removeCycleTimer()
            }else{
                pageControl.isHidden = false
                addCycleTimer()
            }
            //3.默认滚动到中间的一个位置
            let  indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at:indexPath,at: .left, animated: false)
        }
    }
    //定义控件
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    //系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControl.setValue(UIImage(named:"gamble_progress_white"), forKey: "_pageImage")
        pageControl.setValue(UIImage(named: "gamble_progress_orange"), forKey: "_currentPageImage")
        //设置该控件不随着父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册collectionView
        collectionView.register( UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: xqCycleCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置layout属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
//提供一个快速创建View的类方法
extension GeneralCycleView {
    class func generalCycleView() -> GeneralCycleView{
        return Bundle.main.loadNibNamed("GeneralCycleView", owner: nil, options: nil)?.first as! GeneralCycleView
    }
}
//遵守UICollectionViewDataSource的数据源
extension GeneralCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        return cell
    }
}
//遵守UICollectionViewDelegate的数据源
extension GeneralCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleScrollViewDidSelect!(at: pageControl.currentPage, cycleScrollView: self)

    }

}
//对定时器的操作方法
extension GeneralCycleView{
    //添加定时器
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
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
        let currentoffsetX = collectionView.contentOffset.x
        let offsetX = currentoffsetX + collectionView.bounds.width
        //滚动到那个位置
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}
