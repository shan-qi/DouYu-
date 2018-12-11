//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/29.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private var xqHeaderH : CGFloat = 50
private let xqGameViewH : CGFloat = 90
private let xqRecommendMargin : CGFloat = 10
private let xqAddImageView : CGFloat = 60
class RecommendViewController: BaseTotalViewController {
    var recordDistance : Double = 0.0
    private lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var animationImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"btn_livevideo_start_home"))
        imageView.animationImages = [UIImage(named:"guide_floatingMenu_btn0")!,UIImage(named:"guide_floatingMenu_btn1")!,UIImage(named:"guide_floatingMenu_btn2")!,UIImage(named:"guide_floatingMenu_btn3")!]
        imageView.animationDuration = 2
        imageView.animationRepeatCount = 2
        imageView.isUserInteractionEnabled = true
        /////添加tapGuestureRecognizer手势
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        imageView.addGestureRecognizer(tapGR)
        imageView.frame = CGRect(x: xqScreenW - 80, y: xqScreenH - xqAddImageView * 4 , width: xqAddImageView, height: xqAddImageView)
        return imageView
    }()
    private lazy var recommendCycle : RecommendCycleView = {
       let recommendCycle = RecommendCycleView.recommendCycleView()
        recommendCycle.frame = CGRect(x: 0, y: -xqHeaderH, width: xqScreenW, height: xqHeaderH)
        recommendCycle.backgroundColor = UIColor.white
        recommendCycle.delegate = self
        recommendCycle.collectionView.isScrollEnabled = false
        return recommendCycle
    }()
    private lazy var recommendGameView : RecommendGameView = {
       let recommendGameView = RecommendGameView.recommendGameView()
        recommendGameView.frame = CGRect(x: 0 , y: -(xqGameViewH + xqHeaderH), width: xqScreenW, height: xqGameViewH)
        recommendGameView.delegate = self
        return recommendGameView
    }()
    private lazy var recommendCycleView : GeneralCycleView = {
        let recommendCycleView = GeneralCycleView.generalCycleView()
        recommendCycleView.frame = CGRect(x: 0, y: -(xqCycleViewH + xqGameViewH + xqHeaderH), width: xqScreenW, height: xqCycleViewH)
        return recommendCycleView
    }()
    override func setupUI(){
        super.setupUI()
        setAnimationImageView()
        //1.添加collectionView
        view.addSubview(collectionView)
        view.insertSubview(animationImageView, aboveSubview: collectionView)
        collectionView.addSubview(recommendCycle)
        collectionView.addSubview(recommendGameView)
        collectionView.addSubview(recommendCycleView)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize(width: xqScreenW, height: xqHeaderH)
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: xqHeaderH + xqGameViewH + xqCycleViewH, left: 0, bottom: 50, right: 0)
        collectionView.register(UINib(nibName: "CollectionRecommendReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: xqHeaderViewID)
    }
}
extension RecommendViewController{
    override func loadData() {
        print("下拉刷新成功")
        //pragma mark: -给父类中ViewModel进行赋值
        baseVM = recommendViewModel
        //pragma mark: -下方推荐数据
        recommendViewModel.requestData {[weak self] in
            self?.collectionView.reloadData()
            self?.loadDataFinished()
        }
        //pragma mark: -推荐左右游戏滚动数据
        recommendViewModel.requestRecommendGameData {
            var recommendClasifys = self.recommendViewModel.recommendGameModels
            for _ in 0..<9{
                recommendClasifys.removeLast()
            }
            self.recommendGameView.classifys = self.recommendViewModel.recommendGameModels
            let moreClassify = ClassifyModel()
            moreClassify.cate2_name = "更多"
            recommendClasifys.append(moreClassify)
            self.recommendGameView.classifys = recommendClasifys
        }
        
        //pragma mark: -推荐上下滚动数据
        recommendViewModel.requestRecommendData {
            if self.recommendViewModel.recommendModels.isEmpty{
                self.recommendCycle.isHidden = true
                self.recommendGameView.y += xqHeaderH
                self.recommendCycleView.y += xqHeaderH
                self.collectionView.contentInset = UIEdgeInsets(top: xqGameViewH + xqCycleViewH, left: 0, bottom: 50, right: 0)
            }else{
                self.recommendCycle.cycleModels = self.recommendViewModel.recommendModels
            }
            
        }
        
        recommendViewModel.requestRecommendPictureData {[weak self] in
            self?.recommendCycleView.cycleModels = self?.recommendViewModel.cycleModels
        }
    }
    func setAnimationImageView(){
        animationImageView.startAnimating()
    }
    ///手势处理函数
    @objc func tapHandler(sender:UITapGestureRecognizer) {
        let publishVC = XQPublishViewController()
        UIApplication.shared.keyWindow?.rootViewController?.present(publishVC, animated: false, completion: nil)
    }
}
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    override func setUpRefreshHeader() {
        
    }
    override func setUpRefreshFooter() {
        self.collectionView.configRefreshFooter(container: self) {[weak self] in
            delay(0.5, closure: {
                self?.collectionView.switchRefreshFooter(to: .noMoreData)
            })
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
           let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqRecommendCellID, for: indexPath) as! RecommendViewCell
            weak var weakCell = cell
            weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else if indexPath.section == 1{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: xqPrettyCellID, for: indexPath) as! CollectionPrettyCell
            weak var weakCell = cell
            weakCell?.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: xqHeaderViewID, for: indexPath) as! CollectionRecommendReusableView
        if indexPath.section == 0 {
            headerView.iconImageView.image = UIImage(named: "home_header_hot")
            headerView.titleLabel.text = "热门推荐"
        }else if indexPath.section == 1{
            headerView.titleLabel.text = "颜值"
            headerView.iconImageView.image = UIImage(named:"yanzhi")
        }else{
            headerView.group = baseVM.anchorGroups[indexPath.section]
        }
        headerView.moreButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: xqNormalItemW, height: xqPrettyItemH)
        }
        return CGSize(width: xqNormalItemW, height: xqNormalItemH)
    }
    
    @objc func tapped(_ button:UIButton){
        print(button.title(for: .normal) ?? "")
   }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.recordDistance = Double(scrollView.contentOffset.y)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Double(scrollView.contentOffset.y ) > self.recordDistance {
            self.animationImageView.isHidden = true
        }
        if Double(scrollView.contentOffset.y) < self.recordDistance {
            self.animationImageView.isHidden = false

        }
        if !self.animationImageView.isHidden {
            self.animationImageView.isHidden = false
        }

    }
}
extension RecommendViewController : xqRecommendCycleViewDelegate{
    func cycleRecommendScrollViewDidSelect(cycleScrollView: RecommendCycleView) {
        let webVC = WKWebViewController()
        webVC.load_UrlSting(string: "http://apiv2.douyucdn.cn/H5/Subactivity/intro?cid2=0&client_sys=ios&ic=0")
        navigationController?.pushViewController(webVC, animated: true)
    }
}
extension RecommendViewController : xqRecommendGameViewDelegate{
    func cycleRecommendScrollViewDidSelect(at index : Int,cycleScrollView : RecommendGameView){
        if index == 7{
           let VC = RecommendGameDataViewController()
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
    }
}

