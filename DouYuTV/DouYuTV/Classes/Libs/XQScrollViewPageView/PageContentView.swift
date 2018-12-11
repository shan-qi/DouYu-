//
//  PageContentView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit


@objc protocol pageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView , progress : CGFloat ,sourceIndex:Int,targetIndex : Int)
    
    @objc optional func contentViewEndScroll(_ contentView : PageContentView)
}
private let xqContentID = "xqContentID"
class PageContentView: UIView {
    
    //pragma mark: -对外属性
    weak var delegate : pageContentViewDelegate?
    //属性定义
    private var childVcs : [UIViewController]!
    private var startOffsetX : CGFloat = 0
    private var  isForbidScrollDelegate : Bool = false
    private weak var parentViewController : UIViewController?
    
    private lazy var layout : UICollectionViewFlowLayout = {
         //创建layout布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self.bounds.size)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    //懒加载UICollectionView
    lazy var collectionView : UICollectionView = {[weak self] in
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.frame = bounds
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: xqContentID)
        return collectionView
        }()    
    //自定义构造函数
    init(frame : CGRect , childVcs : [UIViewController], parentViewContrller : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewContrller
        super.init(frame: frame)
        //设置UI
        setUpUI()
    }
    func refreshColllectionView(height : CGFloat) {
        collectionView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: height)
        layout.itemSize = collectionView.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageContentView{
    //设置UI界面
    private func setUpUI(){
        //将所有的子控制器添加到父控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        //添加UICollectionView，用于Cell控制器中的View
        addSubview(collectionView)
        collectionView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
//遵守UICollectionViewDataSource的协议
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqContentID, for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }        
        //给cell设置内容
        let childVC = childVcs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

//遵守UICollectionViewDelegate的协议
extension PageContentView : UICollectionViewDelegate{
    //当前视图的偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是否是点击事件
        if isForbidScrollDelegate {return}
        //0.1 判断和开始的时候偏移量是否一致
        guard startOffsetX != scrollView.contentOffset.x else{return}
        //1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //2.判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x 
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4.如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            //4.如果完全滑过去
            if startOffsetX - currentOffsetX == scrollViewW{
                progress = 1
                sourceIndex = targetIndex
            }
        }
        //将progress、sourceIndex、targetIndex传进去
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    // scollView 停止减速的时候处理事情
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewEndScroll?(self)
    }
    // 停止拖拽的湿乎乎处理事情
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.contentViewEndScroll?(self)
        }
    }
}
//对外暴露方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int) {
        //记录需要禁止的执行代理
        isForbidScrollDelegate = true
        //滚动到正确的位置
        let  offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
