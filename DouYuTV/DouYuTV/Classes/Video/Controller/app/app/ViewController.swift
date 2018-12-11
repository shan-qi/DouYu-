//
//  ViewController.swift
//  app
//
//  Created by 单琦 on 2018/5/31.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30), collectionViewLayout: EmjoyCollectionViewLayout())
//        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
    }
    


}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    /**
     返回每个分组有几个数据
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return 32;
    }
    /**
     返回有几个分组
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        
        return 2;
    }
}

