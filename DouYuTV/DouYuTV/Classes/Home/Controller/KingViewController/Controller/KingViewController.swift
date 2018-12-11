//
//  KingViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/11.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private var xqRecommendCycleH : CGFloat = 50
private var xqCycleH : CGFloat = (xqScreenW * 3) / 8
class KingViewController: BaseTotalViewController {
    private lazy var kingVM : KingViewModel = KingViewModel()
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
    private lazy var kingTitleView : PageSubTitleView = {
        let style = XQTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.font = UIFont.systemFont(ofSize: 17.0)
        let titles = ["直播","视频","动态"]
        let titlesFrame = CGRect(x:0, y:  xqRecommendCycleH + xqCycleViewH, width: (xqScreenW / 3) * CGFloat(titles.count), height: xqTitleViewH)
        let titlesView = PageSubTitleView(frame: titlesFrame, titles: titles, style: style)
        titlesView.delegate = self
        return titlesView
    }()
    private lazy var pageContentView : PageContentView = {
        let downContentH : CGFloat = xqScreenH - xqTitleViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y: xqTitleViewH  + xqRecommendCycleH + xqCycleViewH, width:xqScreenW, height:downContentH)
        //2.确定子控制器
        var childVcs = [UIViewController]()
        childVcs.append(KingBrocastViewController())
        childVcs.append(KingVideoViewController())
        childVcs.append(KingDynamicViewController())
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.collectionView.isScrollEnabled = false
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cycleView)
        view.addSubview(recommendCycle)
        view.addSubview(kingTitleView)
        view.addSubview(pageContentView)
        view.insertSubview(pageContentView, belowSubview: kingTitleView)
    }
    deinit {
        cycleView.delegate = nil
        recommendCycle.delegate = nil
        kingTitleView.delegate = nil
    }
}
extension KingViewController{
    override func loadData() {
        baseVM = kingVM
        kingVM.requestCyclePictureData {[weak self] in
            if(self?.kingVM.cycleModels.isEmpty)!{
                self?.cycleView.isHidden = true
                self?.recommendCycle.y -= xqCycleViewH
                self?.kingTitleView.y -= xqCycleViewH
                self?.pageContentView.y -= xqCycleViewH
            }else{
               self?.cycleView.cycleModels = self?.kingVM.cycleModels
            }            
        }
        //pragma mark: -推荐上下滚动数据
        kingVM.requestRecommendData {
            if self.kingVM.recommendModels.count == 0{
                self.recommendCycle.isHidden = true
                self.kingTitleView.y -= xqRecommendCycleH
                self.pageContentView.y -= xqRecommendCycleH
            }else{
                self.recommendCycle.cycleModels = self.kingVM.recommendModels
            }
        }
        
    }
}
extension KingViewController : xqGeneralCycleViewDelegate{
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: GeneralCycleView) {
        let  cycleModel = self.cycleView.cycleModels?[index]
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: cycleModel?.link)
        navigationController?.pushViewController(xqWeb, animated: true)
    }
}
extension KingViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
extension KingViewController : xqRecommendCycleViewDelegate{
    func cycleRecommendScrollViewDidSelect(cycleScrollView: RecommendCycleView) {
        navigationController?.isNavigationBarHidden = false
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: "http://apiv2.douyucdn.cn/H5/Subactivity/intro?cid2=181&client_sys=ios&ic=0")
        navigationController?.pushViewController(xqWeb, animated: true)
    }
}
