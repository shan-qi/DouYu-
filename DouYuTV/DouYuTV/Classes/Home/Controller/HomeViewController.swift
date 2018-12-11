//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqTitlesViewH : CGFloat = 44
// 记录导航栏是否隐藏
private var isNavHidden : Bool = false
class HomeViewController: BaseViewController {
//    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()

    //懒加载属性(pageTitileView)
    private lazy var pageTitleView : PageSubTitleView = {
        let homeTypes = loadTypesData()
        let titles = homeTypes.map({$0.title})
        let style = XQTitleStyle()
        style.font = UIFont.systemFont(ofSize: 15.0)
        style.titleGradColors = kGradientColors
        style.isShowBottomLine = false
        style.isNeedScale = true
        style.scaleRange = 1.1
        let pageFrame = CGRect(x: 0, y:0, width: xqScreenW, height: xqTitlesViewH)
        let titlesView = PageSubTitleView(frame: pageFrame, titles: titles, style: style)
        titlesView.titleLabels[0].textColor = style.normalColor
        titlesView.titleLabels[1].textColor = style.selectedColor
        titlesView.delegate = self
        return titlesView
    }()
    //懒加载属性(PageContentView)
    private lazy var pageContentView : PageContentView = {
        //1.确定内容的frame
        let pageContentH : CGFloat = xqScreenH  - xqTitlesViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y:  xqTitlesViewH, width:xqScreenW, height:pageContentH)
        //2.确定子控制器
        var childVcs = [UIViewController]()
        childVcs.append(ClassyViewController())
        childVcs.append(RecommendViewController())
//        childVcs.append(TotalViewController())
//        childVcs.append(StimulateViewController())
//        childVcs.append(SurvivalViewController())
//        childVcs.append(KingViewController())
//        childVcs.append(LOLViewController())
//        childVcs.append(HostGameViewController())
//        childVcs.append(QQFlyingCarViewController())
//        childVcs.append(WholeArmyViewController())
//        childVcs.append(DOTA2ViewController())
//        childVcs.append(HearthStoneViewController())
//        childVcs.append(DNFViewController())
//        childVcs.append(CFViewController())
//        childVcs.append(OnlineViewController())
//        childVcs.append(SingleViewController())
//        childVcs.append(LeisureViewController())
//        childVcs.append(EntertainmentViewController())
//        childVcs.append(FaceViewController())
//        childVcs.append(ScienceViewController())
//        childVcs.append(PositiveEnergyViewController())
//        childVcs.append(VoiceBroadcastViewController())
//        childVcs.append(SportViewController())
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.delegate = self
        pageContentView.collectionView.contentOffset = CGPoint(x: xqScreenW, y: 0)
        return pageContentView
    }()
    private func loadTypesData() ->[HomeStyle] {
        let path = Bundle.main.path(forResource: "Home", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!) as? [[String: Any]] ?? []
        var tempArray = [HomeStyle]()
        for dict in dataArray {
            tempArray.append(HomeStyle(dict:dict))
        }
        return tempArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        //设置UI界面
        setUI()
        //设置导航栏
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshNavBar), name: NSNotification.Name(rawValue: "XQNotiRefreshHomeNavBar"), object: nil)
    }
    //设置UI界面
    private  func setUI(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 添加标题栏
        setUpPageTitleAndContentView()
        
        // 添加导航栏
        setUpNavigation()
    }
    
    func setUpPageTitleAndContentView() {
        //添加PageContentView
        view.addSubview(pageContentView)
        view.addSubview(pageTitleView)
    }
   
}
extension HomeViewController{

    // MARK: 导航栏隐藏与显示
    @objc func refreshNavBar(noti:Notification) {
        let isHidden : String = noti.userInfo!["isHidden"] as! String
        if isHidden == "true" {
            if isNavHidden {return}
            isNavHidden = true
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: xqStatusBarH, width: xqScreenW, height: xqCateTitleH)
                let height : CGFloat = xqScreenH - xqStatusBarH - XQNavigationBarHeight - xqCateTitleH - xqBarbarH
                let frame = CGRect(x: 0, y: xqCateTitleH + xqStatusBarH, width: xqScreenW, height: height)
                self.pageContentView.frame = frame
                self.pageContentView.refreshColllectionView(height: self.pageContentView.frame.size.height)
            }
        }else{
            if !isNavHidden { return }
            isNavHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 0.15) {
                self.pageTitleView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqCateTitleH)
                let height : CGFloat = xqScreenH - xqStatusBarH - XQNavigationBarHeight - xqCateTitleH - xqBarbarH
                let frame = CGRect(x: 0, y: xqCateTitleH, width: xqScreenW, height: height)
                self.pageContentView.frame = frame
            }
        }
        
    }
}
//遵守pageTitleViewDelegate协议
extension HomeViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
   
}
//遵守pageContentViewDelegate协议
extension HomeViewController : pageContentViewDelegate{
    func contentViewEndScroll(_ contentView: PageContentView) {
        pageTitleView.contentViewDidEndScroll()
    }
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



