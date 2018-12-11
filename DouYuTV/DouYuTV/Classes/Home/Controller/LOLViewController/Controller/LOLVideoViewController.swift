//
//  LOLVideoViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqLOLVideoID = "xqLOLVideoID"
class LOLVideoViewController: BaseTotalViewController {
    private lazy var LOLVideoVM : BaseVideoViewModel  = BaseVideoViewModel()
    var flag : Bool = false
}
extension LOLVideoViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: NormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = xqItemMargin / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:280, right: 0)
        collectionView.register(UINib(nibName: "KingCollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqLOLVideoID)
        collectionView.register(UINib(nibName: "CollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
    }
}
//pragma mark: -发送网络请求
extension LOLVideoViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = LOLVideoVM
        LOLVideoVM.requestLOLData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        flag = true
        print("上拉加载成功")
        baseVM = LOLVideoVM
        LOLVideoVM.loadLOLMoreData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension LOLVideoViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCount = LOLVideoVM.anchorGroups[indexPath.section].anchors[indexPath.row].video?.count ?? 0
            if videoCount == 0 {
                    let  cell = collectionView.dequeueReusableCell(withReuseIdentifier:xqLOLVideoID , for: indexPath) as! KingCollectionVideoCell
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
        let videoCount = LOLVideoVM.anchorGroups[indexPath.section].anchors[indexPath.row].video?.count ?? 0
        if videoCount == 0 {
            return CGSize(width: NormalItemW, height: 300)
        }
            return CGSize(width: NormalItemW, height: NormalItemH)
    }
}
