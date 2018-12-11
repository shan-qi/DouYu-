//
//  DynamicVideoCollectionView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/4.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class DynamicVideoCollectionView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,NibLoadable {
    
    var ThumbVideo : [[String : Any]]?{
        didSet{
            reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        backgroundColor = UIColor.clear

        collectionViewLayout = DynamicVideoCollectionViewFlowLayout()
        ym_registerCell(cell: DynamicCollectionViewVideoCell.self)
        isScrollEnabled = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ThumbVideo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as DynamicCollectionViewVideoCell
        cell.thumb_video = ThumbVideo![indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: xqScreenW - 30, height: 200)
    }
    
}
class DynamicVideoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5        
    }
}
