//
//  XQCategroyScrollItem.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

private let itemWH : CGFloat = xqScreenW / 4

class XQCategroyScrollItem: XQBaseCollectionViewCell {
    
    var dataArr : [XQRecomCateList]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = kWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(XQCategoryItem.self, forCellWithReuseIdentifier: XQCategoryItem.identifier())
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    override func xq_initWithView() {
        addSubview(collectionView)
    }
}

extension XQCategroyScrollItem : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: XQCategoryItem.identifier(), for: indexPath) as! XQCategoryItem
        cell.contentView.layer.borderColor = klineColor.cgColor
        cell.contentView.layer.borderWidth = 0.5
        cell.model = dataArr?[indexPath.row]
        return cell
    }
}
