//
//  BaseTotalViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import WebKit
import SafariServices
import PullToRefreshKit

let xqNormalItemW : CGFloat = (xqScreenW - 3*xqItemMargin) / 2
let xqNormalItemH : CGFloat = (xqNormalItemW * 3) / 4
let xqPrettyItemH : CGFloat = (xqNormalItemW * 4) / 3
private let xqSuriveCellID = "xqSuriveCellID"
class BaseTotalViewController: BaseViewController {
    var baseVM : BaseViewModel!
    var currentIndex = 0
    private lazy var totalVM : TotalViewModel = TotalViewModel()
    //pragma mark: -懒加载
    lazy var collectionView : UICollectionView = {[weak self] in
        //pragma mark: -设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: xqNormalItemW, height:xqNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = xqItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: xqItemMargin, bottom: 0, right: xqItemMargin)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "RecommendViewCell", bundle: nil), forCellWithReuseIdentifier: xqRecommendCellID)
        
        collectionView.register(UINib(nibName: "CollectionDynamicCell", bundle: nil), forCellWithReuseIdentifier: DynamicCellID)
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: xqNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: xqPrettyCellID)
       
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //pragma mark: -设置UI界面
        setupUI()
        loadPCGameData()
        //pragma mark: -加载数据
        loadData()
        loadCycleData()
        //pragma mark: -下拉刷新数据
        setUpRefreshHeader()
        //pragma mark: -上拉加载更多
        setUpRefreshFooter()
       
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.scrollIndicatorInsets = collectionView.contentInset
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    deinit {
        collectionView.delegate = nil
        print("VC deinit")
    }
}
//pragma mark: -设置UI界面
extension  BaseTotalViewController{
    override  func setupUI(){

        //1.给父类中引用View进行赋值
        contentView = collectionView
        //2.添加collectionView
        view.addSubview(collectionView)
        //3.添加super.setupUI
        super.setupUI()
    }
}
extension BaseTotalViewController{
    @objc func loadPCGameData(){}
    @objc func loadData(){}
    @objc func loadCycleData(){}
    @objc func loadMoreData(){}
}
extension BaseTotalViewController{
    //pragma mark: -下拉刷新
   @objc func setUpRefreshHeader(){
        self.collectionView.configRefreshHeader(with: GeneralRegreshHeader(), container: self) {[weak self] in
            delay(0.5, closure: {
            self?.baseVM.anchorGroups.removeAll()
            self?.baseVM.dynamicModel.removeAll()
            
            self?.loadData()
            self?.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
            self?.collectionView.switchRefreshFooter(to: .normal)
            })
        }
    }
    //pragma mark: -上拉加载
  @objc  func setUpRefreshFooter(){
        self.collectionView.configRefreshFooter(container: self) {[weak self] in
            delay(0.5, closure: {
                self?.loadMoreData()
                self?.collectionView.switchRefreshFooter(to: .normal)
            })
        }
    }
}
//pragma mark: -遵守UICollectionView的数据源协议
extension BaseTotalViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqNormalCellID, for: indexPath) as! CollectionNormalCell
        weak var weakCell = cell
            weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
}
//pragma mark: -遵守UICollectionView的代理协议
extension BaseTotalViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //获取主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        anchor.is_vertical == 0 ? presentNormalRoomView(anchor:anchor) : pushShowRoomView(anchor:anchor)
    }
    //0->电脑直播(普通直播)
    func presentNormalRoomView(anchor:AnchorModel){
            let webVC = WKWebViewController()
            webVC.delegate = self
            webVC.load_UrlSting(string: anchor.jump_url)
            navigationController?.pushViewController(webVC, animated: true)
    }
    //1->手机直播(秀场直播)
    func pushShowRoomView(anchor:AnchorModel){
        if #available(iOS 11.3, *) {
            // 1.创建SFSafariViewController
            let safariVC = SFSafariViewController(url: URL(string: anchor.jump_url)!)
            // 2.以Modal方式弹出
            present(safariVC, animated: true, completion: nil)
        } else {
            let webVC = WKWebViewController()
            webVC.load_UrlSting(string: anchor.jump_url)
            present(webVC, animated: true, completion: nil)
        }
    }
    

}
extension BaseTotalViewController:WKWebViewDelegate{
    
    func didSelectRightItem(webView: WKWebView, itemTag: String) {
        print("点击了右边按钮")
        if itemTag == "road" {
            webView.reload()
        }
    }
    
    func didRunJavaScript(webView: WKWebView, result: Any?, error: Error?) {
        print("执行JS结果")
    }
    
    func didAddScriptMessage(webView: WKWebView, message: WKScriptMessage) {
        print("=====\(message.body)")
    }
}


