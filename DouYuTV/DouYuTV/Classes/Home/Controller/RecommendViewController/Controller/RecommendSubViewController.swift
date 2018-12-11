//
//  RecommendSubViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/15.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqRecommendMoreID = "xqRecommendMoreID"
private let xqItemW : CGFloat = (xqScreenW )  /  4
private let xqItemH : CGFloat = 90
class RecommendSubViewController: BaseViewController {
    var home : HomeStyle!
    fileprivate lazy var recommendMoreVM : RecommendViewModel = RecommendViewModel()
    //pragma mark: -懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        //pragma mark: -设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: xqItemW, height:xqItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        return collectionView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        collectionView.register(UINib(nibName: "BaseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:xqRecommendMoreID)
    }
}
extension RecommendSubViewController{
    fileprivate func loadData() {
        recommendMoreVM.requestData(type: home!) {[weak self] in
            self?.collectionView.reloadData()
            self?.loadDataFinished()
        }
    }
}
extension RecommendSubViewController {
    override  func setupUI(){
        //1.给父类中引用View进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        //3.添加super.setupUI
        super.setupUI()
    }
}
extension RecommendSubViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendMoreVM.recommendMoreModel.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendMoreVM.recommendMoreModel[section].classify.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqRecommendMoreID, for: indexPath) as! BaseCollectionViewCell
        cell.classifyModel = recommendMoreVM.recommendMoreModel[indexPath.section].classify[indexPath.item]
        return cell
    }
}
