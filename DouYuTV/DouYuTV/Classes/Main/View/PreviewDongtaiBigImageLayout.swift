//
//  PreviewDongtaiBigImageLayout.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/4.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class PreviewDongtaiBigImageLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        itemSize = CGSize(width: collectionView!.width, height: collectionView!.height - 50)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
