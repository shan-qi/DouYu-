//
//  VideoRecommendViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/6/7.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let recVideoID = "recVideoID"
class VideoRecommendViewController: BaseTotalViewController {
    private lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    private lazy var recVideoVM : BaseVideoViewModel  = BaseVideoViewModel()
    private lazy var videoRecCompetition : VideoRecCompetition = {
        let videoRecCompetition = VideoRecCompetition.videoRecCompetition()
        videoRecCompetition.frame = CGRect(x: 0 , y: -90, width: xqScreenW, height: 90)
        return videoRecCompetition
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: NormalItemH)
        layout.sectionInset = UIEdgeInsets(top: xqItemMargin / 2, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = xqItemMargin / 2
        collectionView.register(UINib(nibName: "CollectionVideoCell", bundle: nil), forCellWithReuseIdentifier: recVideoID)
        collectionView.addSubview(videoRecCompetition)
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 90, right: 0)
    }
}
extension VideoRecommendViewController{
    override func loadData() {
        baseVM = recommendViewModel
        baseVM = recVideoVM
        recommendViewModel.requestVideoRecData {
            self.videoRecCompetition.anchorGroups = self.recommendViewModel.anchorGroups
        }
        recVideoVM.requesRecData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        baseVM = recVideoVM
        recVideoVM.requesRecMoreData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension VideoRecommendViewController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recVideoID, for: indexPath) as! CollectionVideoCell
        weak var weakCell = cell
        weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
}

