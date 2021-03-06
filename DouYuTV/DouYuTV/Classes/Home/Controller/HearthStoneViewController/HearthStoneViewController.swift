//
//  HearthStoneViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/29.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private var xqCycleH : CGFloat = (xqScreenW * 3) / 8
//pragma mark: -炉石传说
class HearthStoneViewController: BaseTotalViewController {
    
    private lazy var HeartStoneVM : HeartStoneViewModel = HeartStoneViewModel()

    //pragma mark: -轮播数据
    private lazy var cycleView : GeneralCycleView = {
        let cycleView = GeneralCycleView.generalCycleView()
        cycleView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqCycleViewH)
        cycleView.delegate = self
        return cycleView
    }()
    //懒加载属性(pageTitileView)
    private lazy var HeartStoneTitleView : PageSubTitleView = {
        let style = XQTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.font = UIFont.systemFont(ofSize: 17.0)
        let titles = ["直播","视频推荐"]
        let titlesFrame = CGRect(x:0, y: xqCycleViewH , width: (xqScreenW / 3) * CGFloat(titles.count), height: xqTitleViewH)
        let titlesView = PageSubTitleView(frame: titlesFrame, titles: titles, style: style)
        titlesView.delegate = self
        return titlesView
    }()
    private lazy var pageContentView : PageContentView = {
        let downContentH : CGFloat = xqScreenH - xqTitleViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y: xqTitleViewH + xqCycleViewH , width:xqScreenW, height:downContentH)
        //2.确定子控制器
        var childVcs = [UIViewController]()
        childVcs.append(HeartStoneBrocastViewController())
        childVcs.append(HeartStoneVideoViewController())
        
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.collectionView.isScrollEnabled = false
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cycleView)
        view.addSubview(HeartStoneTitleView)
        view.addSubview(pageContentView)
        view.insertSubview(pageContentView, belowSubview: HeartStoneTitleView)
    }
    deinit {
        cycleView.delegate = nil
        HeartStoneTitleView.delegate = nil
    }
}
extension HearthStoneViewController{
    override func loadData() {
        baseVM = HeartStoneVM
        HeartStoneVM.requestCyclePictureData {[weak self] in
            if (self?.HeartStoneVM.cycleModels.isEmpty)!{
                self?.cycleView.isHidden = true
                self?.HeartStoneTitleView.y -= xqCycleH
                self?.pageContentView.y -= xqCycleH
            }else{
                self?.cycleView.cycleModels = self?.HeartStoneVM.cycleModels
            }
        }
    }
}
extension HearthStoneViewController : xqGeneralCycleViewDelegate{
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: GeneralCycleView) {
        let  cycleModel = self.cycleView.cycleModels?[index]
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: cycleModel?.link)
        navigationController?.pushViewController(xqWeb, animated: true)
    }
}
extension HearthStoneViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
