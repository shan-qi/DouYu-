//
//  VideoViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/30.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqTitlesViewH : CGFloat = 44
class VideoViewController: BaseViewController {
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    //懒加载属性(pageTitileView)
    private lazy var pageTitleView : PageSubTitleView = {
        let homeTypes = loadTypesData()
        let titles = homeTypes.map({$0.title})
        let style = XQTitleStyle()
        style.font = UIFont.systemFont(ofSize: 15.0)
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
        childVcs.append(ClassifyVideoViewController())
        childVcs.append(VideoRecommendViewController())
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.delegate = self
        pageContentView.collectionView.contentOffset = CGPoint(x: xqScreenW, y: 0)
        return pageContentView
    }()
    private func loadTypesData() ->[HomeStyle] {
        let path = Bundle.main.path(forResource: "Video", ofType: "plist")
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
        // 点击事件
        clickAction()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navigation_background"), for: .default)
    }
    //设置UI界面
    private  func setUI(){
        //添加PageContentView
        view.addSubview(pageContentView)
        view.addSubview(pageTitleView)
        // 设置自定义导航栏
        navigationItem.titleView = navigationBar
    }
    
}
extension VideoViewController{
    /// 点击事件
    private func clickAction() {
        // 搜索按钮点击
        navigationBar.didSelectSearchButton = {
        }
        // 头像按钮点击
        navigationBar.didSelectAvatarButton = {[weak self] in
            self!.navigationController?.pushViewController(MineViewController(), animated: true)
        }
        // 历史按钮点击
        navigationBar.didSelectHistoryButton = {
            print(111)
        }
        // 二维码按钮点击
        navigationBar.didSelectScanButton = {
            print(111)
        }
        navigationBar.didSelectMessageButton = {
            print(111)
        }
        
    }
}
//遵守pageTitleViewDelegate协议
extension VideoViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}
//遵守pageContentViewDelegate协议
extension VideoViewController : pageContentViewDelegate{
    func contentViewEndScroll(_ contentView: PageContentView) {
        pageTitleView.contentViewDidEndScroll()
    }
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
