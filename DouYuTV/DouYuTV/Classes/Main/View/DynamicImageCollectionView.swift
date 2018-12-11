//
//  DynamicImageCollectionView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/9/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit


class DynamicImageCollectionView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,NibLoadable {

    var didSelect: ((_ selectedIndex: Int)->())?
    
    
    var isDynamicImage = false
    
    var ThumbImage : [String]?{
        didSet{
            reloadData()
        }
    }
    var largeImages : [String]?{
        didSet{
            reloadData()
        }
    }
    
    
    var imglist : [[String : Any]]?{
        didSet{
            reloadData()
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        backgroundColor = UIColor.clear
        
        
        collectionViewLayout = DynamicImageCollectionViewFlowLayout()
        ym_registerCell(cell: DongtaiCollectionViewCell.self)
        isScrollEnabled = false
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ThumbImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as DongtaiCollectionViewCell
        cell.thumbImage = ThumbImage![indexPath.item]
        if ThumbImage?.count == 1 {
            cell.x = 0
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        if ThumbImage?.count == 1{
            for image in imglist!{
                let size = image["size"] as! [String:Int]
                let height = size["h"]
                let width = size["w"]
                return height! / width! == 1 ? Calculate.collectionViewCellBigHeightSize((ThumbImage?.count)!) : Calculate.collectionViewCellSmallHeightSize((ThumbImage?.count)!)
            }
        }
        return Calculate.collectionViewCellSmallHeightSize((ThumbImage?.count)!)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDynamicImage { didSelect?(indexPath.item); return }
        let previewBigImageVC = PreviewDongtaiBigImageController()
        previewBigImageVC.images = largeImages!
        previewBigImageVC.selectedIndex = indexPath.item
        UIApplication.shared.keyWindow?.rootViewController?.present(previewBigImageVC, animated: false, completion: nil)
    }
}


class DynamicImageCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
        
    }
}
