//
//  BaseClassifyViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/22.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher


private let xqItemW : CGFloat = (xqScreenW )  /  4
private let xqItemH : CGFloat = 90

private let xqHeaderH : CGFloat = 65
private let xqFooterH : CGFloat = 30
private let HeaderViewID = "HeaderViewID"
private let xqStimulateHeaderViewID = "xqStimulateHeaderViewID"
private let xqClassifyID = "xqClassifyID"
private let xqKingCollectionCellID = "xqKingCollectionCellID"
private let xqStimulateCollectionCellID = "xqStimulateCollectionCellID"
private let xqClassifyCollectionCellID = "xqClassifyCollectionCellID"
private let xqFooterViewID = "xqFooterViewID"
class BaseClassifyViewController: UIViewController{
    var baseVM : BaseViewModel!
    //pragma mark: -懒加载
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: xqScreenW, height: xqHeaderH)
        layout.itemSize = CGSize(width:xqItemW, height:xqItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        collectionView.register(UINib(nibName: "BaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqClassifyCollectionCellID)
        
        collectionView.register(UINib(nibName: "KingHeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqKingCollectionCellID)
        collectionView.register(UINib(nibName: "StimulateAllGunsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqStimulateCollectionCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: xqHeaderViewID)
         collectionView.register(UINib(nibName: "KingHeroCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)        
        collectionView.register(UINib(nibName: "KingHeroCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: xqStimulateHeaderViewID)
        
        return collectionView
    }()
    //pragma mark: -系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
}
//pragma mark: -设置UI界面
extension  BaseClassifyViewController{
    private  func setupUI(){
        //1.给父类中引用View进行赋值
        //2.添加collectionView
        view.addSubview(collectionView)
    }
}
extension BaseClassifyViewController{
    @objc  func loadData(){
        
    }
}
//pragma mark: -遵守UICollectionView的数据源协议
extension BaseClassifyViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorClassifyModel.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return baseVM.anchorClassifyModel[section].classify.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqClassifyCollectionCellID, for: indexPath) as! BaseCollectionViewCell
            cell.classifyModel = baseVM.anchorClassifyModel[indexPath.section].classify[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: xqHeaderViewID, for: indexPath) as! CollectionHeaderReusableView
        reusableView.anchorClassifyModel = baseVM.anchorClassifyModel[indexPath.section]
        return reusableView
    }
}






