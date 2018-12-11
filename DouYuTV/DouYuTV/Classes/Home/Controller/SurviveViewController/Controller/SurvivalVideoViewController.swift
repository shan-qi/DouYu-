//
//  SurvivalVideoViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/13.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqSuriveVideoID = "xqSuriveVideoID"
class SurvivalVideoViewController: BaseTotalViewController {
    private lazy var survivalVideoVM : BaseVideoViewModel  = BaseVideoViewModel()
    var flag : Bool = false
}
extension SurvivalVideoViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: NormalItemH)
        layout.minimumLineSpacing = xqItemMargin / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:280, right: 0)
        collectionView.register(UINib(nibName: "CollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
        collectionView.register(UINib(nibName: "KingCollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqSuriveVideoID)
    }
}
//pragma mark: -发送网络请求
extension SurvivalVideoViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = survivalVideoVM
        survivalVideoVM.requestSurvivalData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        flag = true
        print("上拉加载成功")
        baseVM = survivalVideoVM
        survivalVideoVM.loadSurvivalMoreData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension SurvivalVideoViewController : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCount = survivalVideoVM.anchorGroups[indexPath.section].anchors[indexPath.row].video?.count ?? 0
        if videoCount == 0 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier:xqSuriveVideoID , for: indexPath) as! KingCollectionVideoCell
            cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionVideoCell
            cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            cell.labelTag.isHidden = true
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let videoCount = survivalVideoVM.anchorGroups[indexPath.section].anchors[indexPath.row].video?.count ?? 0
        if videoCount == 0 {
            return CGSize(width: NormalItemW, height: 300)
        }
        return CGSize(width: NormalItemW, height: NormalItemH)
    }
}
