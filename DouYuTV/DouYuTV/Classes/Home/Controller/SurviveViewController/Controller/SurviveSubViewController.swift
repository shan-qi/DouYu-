//
//  BaseSubViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/30.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import SafariServices
import PullToRefreshKit


class SurviveSubViewController: BaseViewController {
    var home : HomeStyle!
    fileprivate lazy var surviveVM : SurviveViewModel = SurviveViewModel()
    //pragma mark: -懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        //pragma mark: -设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: xqNormalItemW, height:150)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = xqItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: xqItemMargin, bottom: 0, right: xqItemMargin)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 260, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
        }()    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadData()
        loadMoreData()
        //pragma mark: -下拉刷新数据
        setUpRefreshHeader()
        //pragma mark: -上拉加载更多
        setUpRefreshFooter()
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
        collectionView.register(UINib(nibName: "SurviveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqSurviveCellID)
    }
}
extension SurviveSubViewController{
    //pragma mark: -下拉刷新
    func setUpRefreshHeader(){
        self.collectionView.configRefreshHeader(with: GeneralRegreshHeader(), container: self) {[weak self] in
            delay(0.5, closure: {
                self?.surviveVM.anchorGroups.removeAll()
                self?.loadData()
                self?.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
                self?.collectionView.switchRefreshFooter(to: .normal)
            })
        }
    }
    //pragma mark: -上拉加载
   func setUpRefreshFooter(){
        self.collectionView.configRefreshFooter(container: self) {[weak self] in
            delay(0.5, closure: {
                self?.loadMoreData()
                self?.collectionView.switchRefreshFooter(to: .normal)
            })
        }
    }
}
extension SurviveSubViewController{
    fileprivate func loadData() {
        surviveVM.requestData(type: home!) {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
    fileprivate func loadMoreData() {
        surviveVM.requestMoreData(type: home!) {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }

}
extension SurviveSubViewController {
    override  func setupUI(){
        //1.给父类中引用View进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        //3.添加super.setupUI
        super.setupUI()
    }
}
extension SurviveSubViewController : UICollectionViewDataSource{
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return surviveVM.anchorGroups.count
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return surviveVM.anchorGroups[section].anchors.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var quidCell = UICollectionViewCell()
            if home.suriveID == "2_270" {
               let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqSurviveCellID, for: indexPath) as! SurviveCollectionViewCell
                quidCell = cell
                cell.anchor = surviveVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            }else{
               let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionNormalCell
                quidCell = cell
                cell.anchor = surviveVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            }
            return quidCell
    }
}
//pragma mark: -遵守UICollectionView的代理协议
extension SurviveSubViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取主播信息
        let anchor = surviveVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        anchor.is_vertical == 0 ? presentNormalRoomView(anchor:anchor) : pushShowRoomView(anchor:anchor)
    }
    //0->电脑直播(普通直播)
    func presentNormalRoomView(anchor:AnchorModel){
        let webVC = WKWebViewController()
        webVC.load_UrlSting(string: anchor.jump_url)

        webVC.navigationController?.isNavigationBarHidden = false
        webVC.hidesBottomBarWhenPushed = true
        // 2.以Push方式弹出
        navigationController?.pushViewController(webVC, animated: true)
    }
    //1->手机直播(秀场直播)
    func pushShowRoomView(anchor:AnchorModel){
        if #available(iOS 11.0, *) {
            // 1.创建SFSafariViewController
            let safariVC = SFSafariViewController(url: URL(string: anchor.jump_url)!)
            print(anchor.jump_url!)
            // 2.以Modal方式弹出
            present(safariVC, animated: true, completion: nil)
        } else {
            let webVC = WKWebViewController()
            webVC.load_UrlSting(string: anchor.jump_url)
            present(webVC, animated: true, completion: nil)
        }
    }
    
}

