//
//  DOTA2ViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/29.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private var xqCycleH : CGFloat = (xqScreenW * 3) / 8
//pragma mark: -DOTA2
class DOTA2ViewController: BaseTotalViewController {

    private lazy var DOTA2VM : DOTA2ViewModel = DOTA2ViewModel()
    //pragma mark: -轮播数据
    private lazy var cycleView : GeneralCycleView = {
        let cycleView = GeneralCycleView.generalCycleView()
        cycleView.frame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqCycleViewH)
        cycleView.delegate = self
        return cycleView
    }()
    //懒加载属性(pageTitileView)
    private lazy var DOTA2TitleView : PageSubTitleView = {
        let style = XQTitleStyle()
        style.isScrollEnable = false
        style.isShowBottomLine = true
        style.font = UIFont.systemFont(ofSize: 17.0)
        let titles = ["直播","视频","动态"]
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
        childVcs.append(DOTA2BrocastViewController())
        childVcs.append(DOTA2VideoViewController())
        childVcs.append(DOTA2DynamicViewController())
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.collectionView.isScrollEnabled = false
        return pageContentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cycleView)
        view.addSubview(DOTA2TitleView)
        view.addSubview(pageContentView)
        view.insertSubview(pageContentView, belowSubview: DOTA2TitleView)
    }
    deinit {
        cycleView.delegate = nil
        DOTA2TitleView.delegate = nil
    }
}
extension DOTA2ViewController{
    override func loadData() {
        baseVM = DOTA2VM
        DOTA2VM.requestCyclePictureData {[weak self] in
            if(self?.DOTA2VM.cycleModels.isEmpty)!{
                self?.cycleView.isHidden = true
                self?.DOTA2TitleView.y -= xqCycleH
                self?.pageContentView.y -= xqCycleH
            }else{
                self?.cycleView.cycleModels = self?.DOTA2VM.cycleModels
            }
        }
    }
}
extension DOTA2ViewController : xqGeneralCycleViewDelegate{
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: GeneralCycleView) {
        let  cycleModel = self.cycleView.cycleModels?[index]
        let xqWeb = WKWebViewController()
        xqWeb.load_UrlSting(string: cycleModel?.link)
        navigationController?.pushViewController(xqWeb, animated: true)
    }
}
extension DOTA2ViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

