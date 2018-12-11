//
//  PositiveEnergyViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class PositiveEnergyViewController: BaseTotalViewController {

    //pragma mark: -进行懒加载(OnlineViewModel)
    private lazy var positiveEnergyVM : PositiveEnergyViewModel = PositiveEnergyViewModel()
    private lazy var totalBrocastView : TotalBrocastView = {
        let totalBrocastView = TotalBrocastView.totalBrocastView()
        totalBrocastView.frame = CGRect(x: 0, y: -20, width: xqScreenW, height: 20)
        return totalBrocastView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom:35, right: 0)
        collectionView.addSubview(totalBrocastView)
        collectionView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqScreenH)
    }
}
extension PositiveEnergyViewController{
    override func loadData() {
        
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = positiveEnergyVM
        positiveEnergyVM.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = positiveEnergyVM
        positiveEnergyVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func setUpRefreshFooter() {
        collectionView.configRefreshFooter(container: self) {[weak self] in
            delay(0.5, closure: {
                self?.loadMoreData()
                self?.collectionView.switchRefreshFooter(to: .noMoreData)
            })
        }
    }
}
