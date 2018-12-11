//
//  SportViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SportViewController: BaseTotalViewController {
    private lazy var sportVM : SportViewModel = SportViewModel()
    private lazy var totalBrocastView : TotalBrocastView = {
        let totalBrocastView = TotalBrocastView.totalBrocastView()
        totalBrocastView.frame = CGRect(x: 0, y: -20, width: xqScreenW, height: 20)
        return totalBrocastView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 0, bottom:35, right: 0)
        collectionView.addSubview(totalBrocastView)
    }
}
extension SportViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = sportVM
        sportVM.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = sportVM
        sportVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}


