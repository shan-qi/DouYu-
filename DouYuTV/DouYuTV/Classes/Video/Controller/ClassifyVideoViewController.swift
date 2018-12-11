//
//  ClassifyVideoViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/30.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqItemW : CGFloat = (xqScreenW )  /  4
private let xqItemH : CGFloat = 90
private let xqClassifyCollectionCellID = "xqClassifyCollectionCellID"
class ClassifyVideoViewController: BaseClassifyViewController {
    private lazy var recommendVM : ClassifyViewModel = ClassifyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ClassifyVideoViewController{
    override func loadData() {
        baseVM = recommendVM
        recommendVM.requestVideoClassify {[weak self] in
            self?.collectionView.reloadData()
        }
    }
}
extension ClassifyVideoViewController : UICollectionViewDelegateFlowLayout{
    override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqClassifyCollectionCellID, for: indexPath) as! BaseCollectionViewCell
        cell.classifyVideoModel = baseVM.anchorClassifyModel[indexPath.section].classify[indexPath.item]

        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: xqHeaderViewID, for: indexPath) as! CollectionHeaderReusableView
        reusableView.anchorVideoClassifyModel = baseVM.anchorClassifyModel[indexPath.section]
        return reusableView
    }

}
