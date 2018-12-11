//
//  StimulateViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/29.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
//pragma mark: -刺激战场
class StimulateViewController: BaseTotalViewController {
    private lazy var stimulateVM : StimulateViewModel = StimulateViewModel()
    //pragma mark: -轮播数据
    private lazy var cycleView : GeneralCycleView = {
        let cycleView = GeneralCycleView.generalCycleView()
        cycleView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqCycleViewH)
        cycleView.delegate = self
        return cycleView
    }()
    //懒加载属性(pageTitileView)
    private lazy var stimulateTitleView : PageSubTitleView = {
        let style = XQTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.font = UIFont.systemFont(ofSize: 17.0)
        let titles = ["直播","视频推荐","主播动态"]
        let titlesFrame = CGRect(x:0, y: xqCycleViewH, width: (xqScreenW / 3) * CGFloat(titles.count), height: 40)
        let titlesView = PageSubTitleView(frame: titlesFrame, titles: titles, style: style)
        titlesView.delegate = self
        return titlesView
    }()
    private lazy var pageContentView : PageContentView = {
        let downContentH : CGFloat = xqScreenH - xqTitleViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y: xqTitleViewH + xqCycleViewH, width:xqScreenW, height:downContentH)
        //2.确定子控制器
        var childVcs = [UIViewController]()
        childVcs.append(StimulateBrocastViewController())
        childVcs.append(StimulateVideoViewController())
        childVcs.append(StimulateDynamicViewController())
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.collectionView.isScrollEnabled = false
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cycleView)
        view.addSubview(stimulateTitleView)
        view.addSubview(pageContentView)
        view.insertSubview(pageContentView, belowSubview: stimulateTitleView)
    }
    deinit {
        cycleView.delegate = nil
        stimulateTitleView.delegate = nil
    }
}
extension StimulateViewController{

    override func loadData() {
        baseVM = stimulateVM
        stimulateVM.requestCyclePictureData {[weak self] in
            if(self?.stimulateVM.cycleModels.isEmpty)!{
                self?.cycleView.isHidden = true
                self?.stimulateTitleView.y -= xqCycleViewH
                self?.pageContentView.y -= xqCycleViewH
            }else{
                self?.cycleView.cycleModels = self?.stimulateVM.cycleModels
            }
        }
    }
}
extension StimulateViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
extension StimulateViewController : xqGeneralCycleViewDelegate{
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: GeneralCycleView) {
        let  cycleModel = self.cycleView.cycleModels?[index]
        self.navigationController?.isNavigationBarHidden = false
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: cycleModel?.link)
        self.navigationController?.pushViewController(xqWeb, animated: true)
    }
}
