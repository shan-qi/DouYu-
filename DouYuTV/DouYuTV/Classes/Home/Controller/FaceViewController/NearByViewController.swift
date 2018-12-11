//
//  NearByViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/9.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqNearByCellID = "xqNearByCellID"
class NearByViewController: UIViewController {
    private lazy var totalBrocastView : TotalBrocastView = {
        let totalBrocastView = TotalBrocastView.totalBrocastView()
        totalBrocastView.frame = CGRect(x: 0, y: -20, width: xqScreenW, height: 20)
        return totalBrocastView
    }()
    //pragma mark: -懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        //pragma mark: -设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: xqNormalItemW, height:xqPrettyItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = xqItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: xqItemMargin, bottom: 0, right: xqItemMargin)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 150, right: 0)
        collectionView.register(UINib(nibName: "CollectionNearByCell", bundle: nil), forCellWithReuseIdentifier: xqNearByCellID)
        return collectionView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //pragma mark: -设置UI界面
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        collectionView.addSubview(totalBrocastView)
        view.addSubview(collectionView)
    }
}

//pragma mark: -遵守UICollectionView的数据源协议
extension NearByViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNearByCellID, for: indexPath) as! CollectionNearByCell
        return cell
    }
}
