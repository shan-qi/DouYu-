//
//  DownContentView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/12.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
protocol downContentViewDelegate : class {
    func downContentView(contentView : DownContentView , progress : CGFloat ,sourceIndex:Int,targetIndex : Int)
    func downView(currentIndex : Int)
}
private let xqContentID = "xqContentID"
class DownContentView: UIView {
    //属性定义
    private var childVcs : [UIViewController]
    private var startOffsetX : CGFloat = 0
    private var  isForbidScrollDelegate : Bool = false
    weak var delegate : downContentViewDelegate?
    private weak var parentViewController : UIViewController?
    //懒加载UICollectionView
    private  lazy var collectionView : UICollectionView = {[weak self] in
        //创建layout布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DownContentView{
    //设置UI界面
    private func setUpUI(){
        //将所有的子控制器添加到父控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
        }
        //添加UICollectionView，用于Cell控制器中的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//遵守UICollectionViewDataSource的协议
extension DownContentView : UICollectionViewDataSource{
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

//对外暴露方法
extension DownContentView{
    func setCurrentIndex(currentIndex : Int) {
        //记录需要禁止的执行代理
//        isForbidScrollDelegate = true
        //滚动到正确的位置
        let  offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }

}

