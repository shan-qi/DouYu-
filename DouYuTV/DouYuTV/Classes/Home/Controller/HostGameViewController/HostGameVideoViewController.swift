//
//  HostGameVideoViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqHostGameVideoID = "xqHostGameVideoID"

class HostGameVideoViewController: BaseTotalViewController {
    
    private lazy var HostGameVideoVM : BaseVideoViewModel  = BaseVideoViewModel()
    var flag : Bool = false

}
extension HostGameVideoViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: NormalItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = xqItemMargin / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:280, right: 0)
        collectionView.register(UINib(nibName: "KingCollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqHostGameVideoID)
        collectionView.register(UINib(nibName: "CollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
    }
}
//pragma mark: -发送网络请求
extension HostGameVideoViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = HostGameVideoVM
        HostGameVideoVM.requestHostGameData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        flag = true
        print("上拉加载成功")
        baseVM = HostGameVideoVM
        HostGameVideoVM.loadHostGameMoreData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension HostGameVideoViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 2 {
//                if flag {
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionVideoCell
//                    cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//                    cell.labelTag.isHidden = true
//                    return cell
//                }else{
//                    let  cell = collectionView.dequeueReusableCell(withReuseIdentifier:xqHostGameVideoID , for: indexPath) as! KingCollectionVideoCell
//                    cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//                    return cell
//                }
//            }else{
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionVideoCell
            cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            cell.labelTag.isHidden = true
            return cell
//        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item == 2 {
//            return CGSize(width: NormalItemW, height: 300)
//        }
        return CGSize(width: NormalItemW, height: NormalItemH)
    }
}
