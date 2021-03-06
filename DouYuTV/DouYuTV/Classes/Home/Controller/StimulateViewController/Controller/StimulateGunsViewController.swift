//
//  StimulateGunsViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqItemW : CGFloat = (xqScreenW )  /  5
private let xqItemH : CGFloat = 90

private let xqStimulateHeaderViewID = "xqStimulateHeaderViewID"
private let xqStimulateCollectionCellID = "xqStimulateCollectionCellID"
class StimulateGunsViewController: BaseClassifyViewController {
    fileprivate lazy var stimulateVM : StimulateViewModel = StimulateViewModel()
        
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
extension StimulateGunsViewController{
    override func loadData() {
        baseVM = stimulateVM
        stimulateVM.requestHeroData {[weak self] in
            self?.collectionView.reloadData()
        }
    }
}
extension StimulateGunsViewController{
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
extension StimulateGunsViewController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqStimulateCollectionCellID, for: indexPath) as! StimulateAllGunsCollectionViewCell
        cell.stimulateModel = stimulateVM.anchorClassifyModel[indexPath.section].classify[indexPath.item]
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: xqStimulateHeaderViewID, for: indexPath) as! KingHeroCollectionReusableView
        headerView.heroAnchor = stimulateVM.anchorClassifyModel[indexPath.section]
        return headerView
    }
}
extension StimulateGunsViewController{
    func setNaviC(){
        //隐藏系统的导航栏 不然点击事件受到影响
        self.navigationController?.isNavigationBarHidden=true
        // 创建一个导航栏
        let navBar = XQNavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:64))
        navBar.backgroundColor = UIColor.white
        let leftBtn = UIButton(type: .custom)
        leftBtn.addTarget(self, action: #selector(popToParent), for: .touchUpInside)
        navBar.setNavigationBar(titleText: "全部枪械", font: UIFont.systemFont(ofSize: 20), leftBtn: leftBtn, leftImage: UIImage(named: "navBackBtn")!)
        // 导航栏添加到view上
        self.view.addSubview(navBar)
    }
    @objc func popToParent(){
        navigationController?.popViewController(animated: true)
    }
    
}
