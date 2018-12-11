//
//  ClassyViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/22.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class ClassyViewController: BaseClassifyViewController {
    private lazy var recommendVM : ClassifyViewModel = ClassifyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension ClassyViewController{
    override func loadData() {
      baseVM = recommendVM
        recommendVM.requestRecommendClassify {[weak self] in
            self?.collectionView.reloadData()
        }
    }
}
extension ClassyViewController : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }else{
            return baseVM.anchorClassifyModel[section].classify.count
        }
    }
}
