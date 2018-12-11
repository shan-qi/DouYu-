//
//  HotViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/9.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import SafariServices
class HotViewController: BaseTotalViewController {
    lazy var faceVM : HotViewModel = HotViewModel()
    private lazy var totalBrocastView : TotalBrocastView = {
        let totalBrocastView = TotalBrocastView.totalBrocastView()
        totalBrocastView.frame = CGRect(x: 0, y: -20, width: xqScreenW, height: 20)
        return totalBrocastView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: xqNormalItemW, height: xqPrettyItemH)
        collectionView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom:85, right: 0)
        collectionView.addSubview(totalBrocastView)
        collectionView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqScreenH)
    }
}
extension HotViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = faceVM
        faceVM.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = faceVM
        faceVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension HotViewController : UICollectionViewDelegateFlowLayout{
    //pragma mark: -重写颜值的数据
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqPrettyCellID, for: indexPath) as! CollectionPrettyCell
        weak var weakCell = cell
        weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = faceVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        anchor.is_vertical == 0 ? pushNormalRoomVc(model: anchor) : presentShowRoomVc(model: anchor)
    }
    
    fileprivate func pushNormalRoomVc(model: AnchorModel) {
        let webViewVc = WKWebViewController()
        webViewVc.load_UrlSting(string: model.jump_url)
        show(webViewVc, sender: nil)
    }
    
    fileprivate func presentShowRoomVc(model: AnchorModel) {
        if #available(iOS 9, *) {
            if let url = URL(string: model.jump_url) {
                let webViewVc = SFSafariViewController(url: url)
                present(webViewVc, animated: true, completion: nil)
            }
        } else {
            let webViewVc = WKWebViewController()
            webViewVc.load_UrlSting(string: model.jump_url)
            present(webViewVc, animated: true, completion: nil)
        }
    }
}








