//
//  VoiceBroadcastViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/10.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class VoiceBroadcastViewController: BaseTotalViewController {
    //pragma mark: -进行懒加载(OnlineViewModel)
    private lazy var voiceVM : VoiceViewModel = VoiceViewModel()
    private lazy var totalBrocastView : TotalBrocastView = {
        let totalBrocastView = TotalBrocastView.totalBrocastView()
        totalBrocastView.frame = CGRect(x: 0, y: -20, width: xqScreenW, height: 20)
        return totalBrocastView
    }()
    private lazy var topGameCollectionView : TopGameCollectionView = {
        let topGameCollectionView = TopGameCollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        return topGameCollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topGameCollectionView)
        view.insertSubview(collectionView, belowSubview: topGameCollectionView)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom:110, right: 0)
        collectionView.addSubview(totalBrocastView)
        collectionView.frame = CGRect(x: 0, y: 75, width: xqScreenW, height: xqScreenH)
    }
}
extension VoiceBroadcastViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = voiceVM
        voiceVM.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.voiceVM.classifyModel.removeAll()
            }
            self?.loadDataFinished()
        }
        voiceVM.loadGameData {
            
            self.topGameCollectionView.groups = self.voiceVM.classifyModel
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = voiceVM
        voiceVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
