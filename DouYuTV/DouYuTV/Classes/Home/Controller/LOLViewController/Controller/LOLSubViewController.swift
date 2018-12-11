//
//  LOLSubViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import SafariServices
import PullToRefreshKit
class LOLSubViewController: BaseViewController {
     var home : HomeStyle!
     fileprivate lazy var LOLVM : LOLViewModel = LOLViewModel()
    
    private lazy var heroGameView : LOLGameView = {
        let heroGameView = LOLGameView.lolGameView()
        heroGameView.frame = CGRect(x: 0, y: -120, width: xqScreenW, height: 120)
        heroGameView.delegate = self
        return heroGameView
    }()
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
        collectionView.addSubview(heroGameView)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
        collectionView.register(UINib(nibName: "SurviveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: xqSurviveCellID)
        if home.lolID == "2_1" {
            self.heroGameView.isHidden = false
            collectionView.contentInset = UIEdgeInsets(top: 110, left: 0, bottom: 260, right: 0)
        }else{
            self.heroGameView.isHidden = true
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 260, right: 0)
        }
    }
}
extension LOLSubViewController{
    //pragma mark: -下拉刷新
    func setUpRefreshHeader(){
        self.collectionView.configRefreshHeader(with: GeneralRegreshHeader(), container: self) {[weak self] in
            delay(0.5, closure: {
                self?.LOLVM.anchorGroups.removeAll()
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
extension LOLSubViewController{
    fileprivate func loadData() {
        LOLVM.requestData(type: home!) {[weak self] in
            self?.collectionView.reloadData()
            self?.loadDataFinished()
        }
        LOLVM.requestLolGameData {
            var lolsArray : [ClassifyModel] = []
            var lols = self.LOLVM.lolGameModels
            if(lols.count != 0){
                for i in 0..<4{
                    lolsArray.append(lols[i])
                }
                self.heroGameView.lols = self.LOLVM.lolGameModels
                let moreKing = ClassifyModel()
                moreKing.tag2_name = "全部"
                lolsArray.append(moreKing)
                self.heroGameView.lols = lolsArray
            }else{
                self.heroGameView.isHidden = true
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 260, right: 0)
            }
    
        }
    }
    fileprivate func loadMoreData() {
        LOLVM.requestMoreData(type: home!) {[weak self] in
            self?.collectionView.reloadData()
            self?.loadDataFinished()
        }
    }
}
extension LOLSubViewController {
    override  func setupUI(){
        //1.给父类中引用View进行赋值
        contentView = collectionView
        
        //2.添加collectionView
        view.addSubview(collectionView)
        //3.添加super.setupUI
        super.setupUI()
    }
}
extension LOLSubViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return LOLVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LOLVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var quidCell = UICollectionViewCell()
        if home.lolID == "2_1" {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqSurviveCellID, for: indexPath) as! SurviveCollectionViewCell
            quidCell = cell
            cell.anchor = LOLVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        }else{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionNormalCell
            quidCell = cell
            cell.anchor = LOLVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        }
        return quidCell
    }
}
extension LOLSubViewController : xqLOLGameViewDelegate{
    func cycleLOLScrollViewDidSelect(at index : Int,cycleScrollView : LOLGameView){
        if index == 4{
            let kingHeroTotalVC = LOLHeroTotalViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(kingHeroTotalVC, animated: true)
        }
    }
}
//pragma mark: -遵守UICollectionView的代理协议
extension LOLSubViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取主播信息
        let anchor = LOLVM.anchorGroups[indexPath.section].anchors[indexPath.item]
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

