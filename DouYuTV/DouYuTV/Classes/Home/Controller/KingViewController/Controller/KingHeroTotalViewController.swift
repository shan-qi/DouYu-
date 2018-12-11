//
//  KingHeroTotalViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/13.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqItemW : CGFloat = (xqScreenW )  /  5
private let xqItemH : CGFloat = 90

private let HeaderViewID = "HeaderViewID"
private let xqKingCollectionCellID = "xqKingCollectionCellID"
class KingHeroTotalViewController: BaseClassifyViewController {
    private lazy var kingHeroVM : KingViewModel = KingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRefreshHeader()
        setNaviC()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:xqItemW, height:xqItemH)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: xqScreenW, height: 40)
        collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 30, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
extension KingHeroTotalViewController{
    override func loadData() {
        baseVM = kingHeroVM
        kingHeroVM.requestHeroData {[weak self] in
            self?.collectionView.reloadData()
        }
    }
}
extension KingHeroTotalViewController{
    //pragma mark: -下拉刷新
    func setUpRefreshHeader(){
        self.collectionView.configRefreshHeader(with: GeneralRegreshHeader(), container: self) {[weak self] in
            delay(0.5, closure: {
                self?.baseVM.anchorClassifyModel.removeAll()
                self?.loadData()
                self?.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
                self?.collectionView.switchRefreshFooter(to: .normal)
            })
        }
    }
}
extension KingHeroTotalViewController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqKingCollectionCellID, for: indexPath) as! KingHeroCollectionViewCell
        cell.kingModel = kingHeroVM.anchorClassifyModel[indexPath.section].classify[indexPath.item]
        cell.iconTitle.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
        
   override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewID, for: indexPath) as! KingHeroCollectionReusableView
        headerView.heroAnchor = kingHeroVM.anchorClassifyModel[indexPath.section]
        return headerView
    }
}
extension KingHeroTotalViewController{
    func setNaviC(){
        //隐藏系统的导航栏 不然点击事件受到影响
        self.navigationController?.isNavigationBarHidden=true
        // 创建一个导航栏
        let navBar = XQNavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:64))
        navBar.backgroundColor = UIColor.white
        let leftBtn = UIButton(type: .custom)
        leftBtn.addTarget(self, action: #selector(popToParent), for: .touchUpInside)
        navBar.setNavigationBar(titleText: "全部英雄", font: UIFont.systemFont(ofSize: 20), leftBtn: leftBtn, leftImage: UIImage(named: "navBackBtn")!)
        // 导航栏添加到view上
        self.view.addSubview(navBar)
    }
    @objc func popToParent(){
        navigationController?.popViewController(animated: true)
    }
    
}

