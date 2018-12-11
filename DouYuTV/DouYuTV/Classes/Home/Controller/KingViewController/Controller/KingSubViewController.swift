//
//  KingSubViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/11.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import SafariServices
import PullToRefreshKit
private let xqAddImageView : CGFloat = 60

class KingSubViewController: BaseViewController {
    var recordDistance : Double = 0.0
    var home : HomeStyle!
    fileprivate lazy var kingVM : KingViewModel = KingViewModel()
    
    fileprivate lazy var animationImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"btn_livevideo_onkeyLiveOn"))
        imageView.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        imageView.addGestureRecognizer(tapGR)
        imageView.frame = CGRect(x: xqScreenW - 80, y: 380, width: xqAddImageView, height: xqAddImageView)
        return imageView
    }()
    
    private lazy var heroGameView : KingGameView = {
        let heroGameView = KingGameView.recommendGameView()
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
        if home.kingID == "2_181" {
             self.heroGameView.isHidden = false
            collectionView.contentInset = UIEdgeInsets(top: 110, left: 0, bottom: 260, right: 0)
        }else{
             self.heroGameView.isHidden = true
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 260, right: 0)
        }
    }
}
extension KingSubViewController{
    //pragma mark: -下拉刷新
    func setUpRefreshHeader(){
        self.collectionView.configRefreshHeader(with: GeneralRegreshHeader(), container: self) {[weak self] in
            delay(0.5, closure: {
                self?.kingVM.anchorGroups.removeAll()
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
extension KingSubViewController{
    fileprivate func loadData() {
        kingVM.requestData(type: home!) {[weak self] in
            self?.collectionView.reloadData()
            self?.loadDataFinished()
        }
        kingVM.requestRecommendGameData {
            var kingsArray : [ClassifyModel] = []
            
            var kings = self.kingVM.recommendGameModels
            if(kings.count != 0){
                for i in 0..<4{
                    kingsArray.append(kings[i])
                }
                self.heroGameView.kings = self.kingVM.recommendGameModels
                let moreKing = ClassifyModel()
                moreKing.tag2_name = "全部"
                kingsArray.append(moreKing)
                self.heroGameView.kings = kingsArray
            }else{
                self.heroGameView.isHidden = true
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 260, right: 0)
            }
        }
    }
    fileprivate func loadMoreData() {
        kingVM.requestMoreData(type: home!) {[weak self] in
            self?.collectionView.reloadData()
            self?.loadDataFinished()
        }
    }
    ///手势处理函数
    @objc func tapHandler(sender:UITapGestureRecognizer) {
        let webVC = WKWebViewController()
        webVC.load_UrlSting(string: "https://www.douyu.com/member/anchorh5/mglivetool?aid=ios")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
}
extension KingSubViewController {
    override  func setupUI(){
        //1.给父类中引用View进行赋值
        contentView = collectionView
        
        //2.添加collectionView
        view.addSubview(collectionView)
        view.insertSubview(animationImageView, aboveSubview: collectionView)
        //3.添加super.setupUI
        super.setupUI()
    }
}
extension KingSubViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kingVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kingVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var quidCell = UICollectionViewCell()
        
        
        if home.kingID == "2_181" {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqSurviveCellID, for: indexPath) as! SurviveCollectionViewCell
            quidCell = cell
            cell.anchor = kingVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        }else{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionNormalCell
            quidCell = cell
            cell.anchor = kingVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        }
        return quidCell
    }
    @objc func tapped(_ button:UIButton){
        print(button.title(for: .normal) ?? "")
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.recordDistance = Double(scrollView.contentOffset.y)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Double(scrollView.contentOffset.y ) > self.recordDistance {
            self.animationImageView.isHidden = true
            
        }
        if Double(scrollView.contentOffset.y) < self.recordDistance {
            self.animationImageView.isHidden = false
        }
        if !self.animationImageView.isHidden {
            self.animationImageView.isHidden = false
        }
    }
}
extension KingSubViewController : xqKingGameViewDelegate{
    func cycleKingScrollViewDidSelect(at index : Int,cycleScrollView : KingGameView){
        if index == 4{
            let kingHeroTotalVC = KingHeroTotalViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(kingHeroTotalVC, animated: true)            
        }
    }
}
//pragma mark: -遵守UICollectionView的代理协议
extension KingSubViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取主播信息
        let anchor = kingVM.anchorGroups[indexPath.section].anchors[indexPath.item]
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
