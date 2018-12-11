//
//  BaseAnchorViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqHeaderH : CGFloat = 50

class BaseAnchorViewController: BaseViewController {

    
    var baseVM : BaseViewModel!
    //pragma mark: -懒加载
    lazy var collectionView : UICollectionView = {
        //pragma mark: -设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: xqNormalItemW, height:xqNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = xqItemMargin
        layout.headerReferenceSize = CGSize(width: xqScreenW, height: xqHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: xqItemMargin, bottom: 0, right: xqItemMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: xqPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: xqHeaderViewID)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}
//pragma mark: -设置UI界面
extension  BaseAnchorViewController{
    override  func setupUI(){
        //1.给父类中引用View进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        //3.添加super.setupUI
        super.setupUI()
    }
}
extension BaseAnchorViewController{
    @objc  func loadData(){
        
    }
}
//pragma mark: -遵守UICollectionView的数据源协议
extension BaseAnchorViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: xqHeaderViewID, for: indexPath) as! CollectionHeaderReusableView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
