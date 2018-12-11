//
//  HostGameDynamicViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/5.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class HostGameDynamicViewController: BaseTotalViewController {
    private lazy var hostGameDynamicVM : HostGameViewModel  = HostGameViewModel()
    /// 动态数据
    private lazy var dynamics : [DynamicModel] = [DynamicModel]()
   
}
extension HostGameDynamicViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: NormalItemW, height: 200)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:250, right: 0)
    }
}
//pragma mark: -发送网络请求
extension HostGameDynamicViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = hostGameDynamicVM
        hostGameDynamicVM.requestData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
            self?.loadDataFinished()
        }
    }
    override func loadMoreData() {
        print("上拉加载成功")
        baseVM = hostGameDynamicVM
        hostGameDynamicVM.loadData {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            self?.loadDataFinished()
        }
    }
}
extension HostGameDynamicViewController : UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.dynamicModel.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DynamicCellID, for: indexPath) as! CollectionDynamicCell
        
        weak var weakCell = cell
        weakCell?.anchorDynamic = baseVM.dynamicModel[indexPath.item]
        weakCell?.moreBtn.addTarget(self, action:#selector(moreClick), for:.touchUpInside)
        
        //点击了那张图片
        cell.didSelectCell = { [weak self] (selectedIndex) in
            let previewBigImageVC = PreviewDongtaiBigImageController()
            previewBigImageVC.images = (cell.anchorDynamic?.largeImageArray)!
            previewBigImageVC.selectedIndex = selectedIndex
            self!.present(previewBigImageVC, animated: false, completion: nil)
        }
        return cell
    }
    @objc func moreClick(){
        let alertController = UIAlertController()
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "举报", style: .default, handler: nil)
        let saveAction = UIAlertAction(title: "关注Ta", style: .default, handler: nil)
        // 添加到UIAlertController
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        alertController.addAction(deleteAction)
        // 弹出
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("动态--------点击")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dynamic = baseVM.dynamicModel[indexPath.row]
        return CGSize(width: xqScreenW, height: dynamic.dynamicCellH)
    }
}
