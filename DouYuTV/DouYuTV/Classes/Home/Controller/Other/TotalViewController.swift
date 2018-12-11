//
//  TotalViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class TotalViewController: BaseTotalViewController {
    //pragma mark: -进行懒加载(TotalViewModel)
    private lazy var totalVM : TotalViewModel = TotalViewModel()
}
//pragma mark: -设置UI界面
extension TotalViewController {
    override func setupUI() {
        super.setupUI()
        //添加collectionView
        view.addSubview(collectionView)
       collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}
//pragma mark: -发送网络请求
extension TotalViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = totalVM
        totalVM.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = totalVM
        totalVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }    
}
