//
//  WholeArmyVideoViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqWholeArmyVideoID = "xqWholeArmyVideoID"

class WholeArmyVideoViewController: BaseTotalViewController {
    private lazy var WholeArmyVideoVM : BaseVideoViewModel  = BaseVideoViewModel()
}
extension WholeArmyVideoViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: NormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = xqItemMargin / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:280, right: 0)
        collectionView.register(UINib(nibName: "KingCollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqWholeArmyVideoID)
        collectionView.register(UINib(nibName: "CollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
    }
}
//pragma mark: -发送网络请求
extension WholeArmyVideoViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = WholeArmyVideoVM
        WholeArmyVideoVM.requestWholeArmyData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = WholeArmyVideoVM
        WholeArmyVideoVM.loadWholeArmyMoreData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension WholeArmyVideoViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionVideoCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        cell.labelTag.isHidden = true
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: NormalItemW, height: NormalItemH)
    }
}
