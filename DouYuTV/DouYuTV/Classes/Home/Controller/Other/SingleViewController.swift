//
//  SingleViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SingleViewController: BaseTotalViewController {
    private lazy var singleVM : SingleViewModel = SingleViewModel()
    private lazy var totalBrocastView : TotalBrocastView = {
        let totalBrocastView = TotalBrocastView.totalBrocastView()
        totalBrocastView.frame = CGRect(x: 0, y: -20, width: xqScreenW, height: 20)
        return totalBrocastView
    }()
    private lazy var topGameCollectionView : TopGameCollectionView = {
        let topGameCollectionView = TopGameCollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        return topGameCollectionView
    }()
}
extension SingleViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topGameCollectionView)
        view.insertSubview(collectionView, belowSubview: topGameCollectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom:110, right: 0)
        collectionView.addSubview(totalBrocastView)
        collectionView.frame = CGRect(x: 0, y: 75, width: xqScreenW, height: xqScreenH)
    }
}
extension SingleViewController{
    override func loadData() {
        baseVM = singleVM
        singleVM.requestData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                 self?.singleVM.classifyModel.removeAll()
            }
            self?.loadDataFinished()
        }
        singleVM.loadGameData {
            var onlineGames = self.singleVM.classifyModel
            onlineGames.removeSubrange(16..<onlineGames.count)
            self.topGameCollectionView.groups = self.singleVM.classifyModel
            self.topGameCollectionView.groups = onlineGames
        }
    }
    override func loadMoreData() {
        baseVM = singleVM
        singleVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
