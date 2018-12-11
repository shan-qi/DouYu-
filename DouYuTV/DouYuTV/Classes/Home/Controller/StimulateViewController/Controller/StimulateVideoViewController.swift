//
//  StimulateVideoViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/10.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let NormalCellID = "xqNormalCellID"
class StimulateVideoViewController: BaseTotalViewController {
    private lazy var stimulateVideoVM : BaseVideoViewModel  = BaseVideoViewModel()
}
extension StimulateVideoViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: NormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:280, right: 0)
        collectionView.register(UINib(nibName: "CollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
    }
}
//pragma mark: -发送网络请求
extension StimulateVideoViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = stimulateVideoVM
        stimulateVideoVM.requesStimulatetData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = stimulateVideoVM
        stimulateVideoVM.requesStimulatetMoreData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension StimulateVideoViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionVideoCell
        weak var weakCell = cell
        weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        weakCell?.labelTag.isHidden = true
        return cell
    }
}
