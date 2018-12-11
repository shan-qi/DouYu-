//
//  TopGameCollectionView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqContentID = "xqContentID"
private let xqGameID = "xqGameID"

class TopGameCollectionView: UIView {
    var groups : [ClassifyModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    var flag : Bool = false
     private lazy var collectionView : UICollectionView = {[weak self] in
        //创建layout布局
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        layout.itemSize = CGSize(width: 80, height: 30)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        //创建UICollectionView
        let frame = CGRect(x:0, y:0, width: 375, height: 50)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TopGameCollectionViewCell", bundle: nil)
, forCellWithReuseIdentifier: xqGameID)
        return collectionView
        }()
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 60, width: 375, height: 15))
        imageView.backgroundColor = UIColor(white: 0.0, alpha: 0.01)
        imageView.image = UIImage(named: "footTypeBase")
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var pullAndUpImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: xqScreenW / 2 - 3, y:0, width: 8, height: 6))
        imageView.image = UIImage(named: "footTypeDown")
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI(){
        addSubview(collectionView)
        addSubview(imageView)
        imageView.addSubview(pullAndUpImageView)
    }
}
extension TopGameCollectionView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqGameID, for: indexPath) as! TopGameCollectionViewCell
        cell.onlineModel = groups?[indexPath.item]
        return cell
    }
}
extension TopGameCollectionView {
    @objc func imageViewClick(){
        if !flag {
            flag = true
            UIView.animate(withDuration: 0.25, animations: {
                self.collectionView.frame.size.height = CGFloat(45 * Int(((self.groups?.count)! - 1) / 4) + 60)
                self.imageView.frame.origin.y = self.collectionView.frame.origin.y + self.collectionView.frame.size.height
                self.pullAndUpImageView.image = UIImage(named: "footTypeUp")
                
            })
        }else{
            flag = false
            UIView.animate(withDuration: 0.25, animations: {
                self.collectionView.frame.size.height = 60
                self.imageView.frame.origin.y = self.collectionView.frame.origin.y + self.collectionView.frame.size.height
                self.pullAndUpImageView.image = UIImage(named: "footTypeDown")
            })
        }
    }
}

