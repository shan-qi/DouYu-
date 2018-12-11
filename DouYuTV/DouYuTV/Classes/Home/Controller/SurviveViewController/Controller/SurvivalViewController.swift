
//
//  SurvivalViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/21.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private var xqRecommendCycleH : CGFloat = 50
private var xqCycleH : CGFloat = (xqScreenW * 3) / 8
class SurvivalViewController: BaseTotalViewController {
    private lazy var cycleVM : SurviveViewModel = SurviveViewModel()
    //pragma mark: -轮播数据
    private lazy var cycleView : GeneralCycleView = {
       let cycleView = GeneralCycleView.generalCycleView()
        cycleView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqCycleViewH)
        cycleView.delegate = self
        return cycleView
    }()
    private lazy var recommendCycle : RecommendCycleView = {
        let recommendCycle = RecommendCycleView.recommendCycleView()
        recommendCycle.frame = CGRect(x: 0, y:xqCycleViewH, width: xqScreenW, height: xqRecommendCycleH)
        recommendCycle.backgroundColor = UIColor.white
        recommendCycle.delegate = self
        recommendCycle.collectionView.isScrollEnabled = false
        return recommendCycle
    }()
    //懒加载属性(pageTitileView)
    private lazy var survivalTitleView : PageSubTitleView = {
        let style = XQTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.font = UIFont.systemFont(ofSize: 17.0)
        let titles = ["直播","视频","动态"]
        let titlesFrame = CGRect(x:0, y: xqCycleViewH + xqRecommendCycleH, width: (xqScreenW / 3) * CGFloat(titles.count), height: xqTitleViewH)
        let titlesView = PageSubTitleView(frame: titlesFrame, titles: titles, style: style)
        titlesView.delegate = self
        return titlesView
    }()
    private lazy var pageContentView : PageContentView = {
        let downContentH : CGFloat = xqScreenH - xqTitleViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y: xqTitleViewH + xqCycleViewH + xqRecommendCycleH, width:xqScreenW, height:downContentH)
        //2.确定子控制器
        var childVcs = [UIViewController]()
        childVcs.append(SurvivalBrocastViewController())
        childVcs.append(SurvivalVideoViewController())
        childVcs.append(DynamicViewController())
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.collectionView.isScrollEnabled = false
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cycleView)
        view.addSubview(recommendCycle)
        view.addSubview(survivalTitleView)
        view.addSubview(pageContentView)
        view.insertSubview(pageContentView, belowSubview: survivalTitleView)
    }
}
extension SurvivalViewController{
    
    override func loadData() {
        baseVM = cycleVM
        cycleVM.requestCyclePictureData {[weak self] in
            if(self?.cycleVM.cycleModels.isEmpty)!{
                self?.cycleView.isHidden = true
                self?.recommendCycle.y -= xqCycleViewH
                self?.survivalTitleView.y -= xqCycleViewH
                self?.pageContentView.y -= xqCycleViewH
            }else{
                self?.cycleView.cycleModels = self?.cycleVM.cycleModels
            }
            
        }
        //pragma mark: -推荐上下滚动数据
        cycleVM.requestRecommendData {
            if self.cycleVM.recommendModels.isEmpty{
                self.recommendCycle.isHidden = true
                self.survivalTitleView.y -= xqRecommendCycleH
                self.pageContentView.y -= xqRecommendCycleH
            }else{
                self.recommendCycle.cycleModels = self.cycleVM.recommendModels
            }
        }
    }
}
extension SurvivalViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
extension SurvivalViewController : xqGeneralCycleViewDelegate{
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: GeneralCycleView) {
        let  cycleModel = self.cycleView.cycleModels?[index]
        self.navigationController?.isNavigationBarHidden = false
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: cycleModel?.link)
        self.navigationController?.pushViewController(xqWeb, animated: true)
    }
}
extension SurvivalViewController : xqRecommendCycleViewDelegate{
    func cycleRecommendScrollViewDidSelect(cycleScrollView: RecommendCycleView) {
        navigationController?.isNavigationBarHidden = false
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: "http://apiv2.douyucdn.cn/H5/Subactivity/intro?cid2=270&client_sys=ios&ic=0")
        navigationController?.pushViewController(xqWeb, animated: true)
    }
}





