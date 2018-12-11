//
//  XQCategoryListCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

class XQCategoryListCell: XQBaseTableViewCell {
    
    var cateTwoList : [XQRecomCateList]?{
        didSet{
            collectionView.reloadData()
        }
    }
    //pragma mark: -分页控制器
    lazy var pageControl : UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = colorWithRGBA(236, 236, 236, 1.0)
        pageControl.currentPageIndicatorTintColor = colorWithRGBA(212, 212, 212, 1.0)
        return pageControl
    }()
    
    private lazy var layout : UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = kWhite
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(XQCategroyScrollItem.self, forCellWithReuseIdentifier:XQCategroyScrollItem.identifier())
        // 分页控制
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
        
    }()
    override func xq_initWithView() {
        setUpAllView()
        layout.itemSize = CGSize(width: xqScreenW, height: CateItemHeight * 3.0)
        pageControl.numberOfPages = 12
    }
}
extension XQCategoryListCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cateTwoList == nil{ return 0 }
        
        let pageNum = (cateTwoList!.count - 1) / 12 + 1
        pageControl.numberOfPages = pageNum
        
        if pageNum <= 1 {
            pageControl.isHidden = true
        }else{
            pageControl.isHidden = false
        }
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: XQCategroyScrollItem.identifier(), for: indexPath) as! XQCategroyScrollItem
        
        let startIndex = indexPath.item * 12
        var endIndex = (indexPath.item + 1) * 12 - 1
        if endIndex > cateTwoList!.count - 1 {
            endIndex = cateTwoList!.count - 1
        }
        if (self.cateTwoList?.count)! > 0  {
            cell.dataArr = Array(cateTwoList![startIndex...endIndex])
        }
        
        return cell
    }
}
extension XQCategoryListCell : UICollectionViewDelegate {
    // pageControl 的滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
    }
}
// 配置 UI
extension XQCategoryListCell {
    
    private func setUpAllView (){
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(CateItemHeight * 3)
        }
        
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(37)
        }
        
        
    }
}

