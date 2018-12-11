//
//  FaceViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqSegmentMargin : CGFloat = 15
private let xqSegmentViewH : CGFloat = 50
class FaceViewController: BaseTotalViewController {
//    private lazy var topSegmentView : UIView = {
//        let topSegmentView = UIView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: 50))
//        topSegmentView.backgroundColor = UIColor.white
//        return topSegmentView
//    }()
//
//    private lazy var segmetControl : UISegmentedControl = {
//        let items = ["看热门", "看附近"] as [Any]
//        let segmetControl = UISegmentedControl(items: items)
//        segmetControl.frame =  CGRect(x: xqSegmentMargin, y: 10, width: xqScreenW - 30, height: 30)
//        segmetControl.selectedSegmentIndex = 0
//        segmetControl.tintColor = UIColor.orange
//        segmetControl.addTarget(self, action: #selector(segmentDidchange(_:)),
//                                for: .valueChanged)
//        return segmetControl
//    }()
//    private lazy var hotViewController : HotViewController = {
//        let hotViewController = HotViewController()
//        hotViewController.view.frame = CGRect(x: 0, y: 50, width: xqScreenW, height: xqScreenH)
//        return hotViewController
//    }()
//    private lazy var nearyByViewController : NearByViewController = {
//        let nearyByViewController = NearByViewController()
//        nearyByViewController.view.frame = CGRect(x: 0, y: 50, width: xqScreenW, height: xqScreenH)
//        return nearyByViewController
//    }()
//
//    override func viewDidLoad() {
//        view.addSubview(hotViewController.view)
//        topSegmentView.addSubview(segmetControl)
//        view.addSubview(topSegmentView)
//    }
//    @objc func segmentDidchange(_ segmented:UISegmentedControl){
//        switch segmented.selectedSegmentIndex {
//        case 0:
//            nearyByViewController.view.removeFromSuperview()
//            hotViewController.faceVM.anchorGroups.removeAll()
//            hotViewController.loadData()
//            view.addSubview(hotViewController.view)
//            break
//        case 1:
//            hotViewController.view.removeFromSuperview()
//            view.addSubview(nearyByViewController.view)
//            break
//        default:
//            break
//        }
//    }
    
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
extension FaceViewController{
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
extension FaceViewController : UICollectionViewDelegateFlowLayout{
    //pragma mark: -重写颜值的数据
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqPrettyCellID, for: indexPath) as! CollectionPrettyCell
        weak var weakCell = cell
        weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
}





