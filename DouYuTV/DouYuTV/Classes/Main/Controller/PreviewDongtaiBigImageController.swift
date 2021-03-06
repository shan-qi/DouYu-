//
//  PreviewDongtaiBigImageController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/4.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD
import Photos

class PreviewDongtaiBigImageController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    /// 图片数组
    var images : [String] = []
    /// 图片的序号
    @IBOutlet weak var indexLabel: UILabel!
    /// 选中了第几个 cell
    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.configuration()
        view.backgroundColor = .black
        indexLabel.text = "\(selectedIndex + 1)/\(images.count)"
        collectionView.ym_registerCell(cell: DongtaiCollectionViewCell.self)
        collectionView.collectionViewLayout = PreviewDongtaiBigImageLayout()
        view.layoutIfNeeded()
        // 如果调用scrollToItemAtIndexPath不起作用, 需要先调用layoutIfNeeded方法
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    
    /// 保存图片
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let largeImage = images[selectedIndex]
        ImageDownloader.default.downloadImage(with: URL(string: largeImage)!, progressBlock: { (receivedSize, totalSize) in
            // 获取当前进度
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
        }) { (image, error, imageURL, data) in
            // 调用系统相册，保存到相册
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: { (success, error) in
                SVProgressHUD.dismiss()
                if success { SVProgressHUD.showSuccess(withStatus: "保存成功!") }
            })
        }
    }
}
extension PreviewDongtaiBigImageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as DongtaiCollectionViewCell
        cell.largeImage = images[indexPath.item]
        cell.thumbImageView.contentMode = .scaleAspectFit
        cell.thumbImageView.layer.borderWidth = 0
        cell.backgroundColor = .black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: false, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        selectedIndex = Int(scrollView.contentOffset.x / xqScreenW + 0.5)
        indexLabel.text = "\(selectedIndex + 1)/\(images.count)"
    }
}
