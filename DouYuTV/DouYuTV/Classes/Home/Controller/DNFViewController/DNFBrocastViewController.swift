//
//  DNFBrocastViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

private let xqTitlesViewH : CGFloat = 35

class DNFBrocastViewController: UIViewController {

    private lazy var DNFDownTitileView : PageSubTitleView = {
        let homeTypes = loadTypesData()
        let titles = homeTypes.map({$0.title})
        let style = XQTitleStyle()
        style.font = UIFont.systemFont(ofSize: 13.0)
        style.isShowBottomLine = false
        style.isNeedScale = true
        style.isShowCover = true
        style.normalColor = UIColor.gray
        let pageFrame = CGRect(x: 0, y: 0, width: xqScreenW, height: xqTitlesViewH)
        let titlesView = PageSubTitleView(frame: pageFrame, titles: titles, style: style)
        titlesView.backgroundColor = UIColor.white
        titlesView.splitLineView.isHidden = true
        titlesView.delegate = self
        return titlesView
    }()
    private lazy var pageContentView : PageContentView = {
        let homeTypes = loadTypesData()
        let downContentH : CGFloat = xqScreenH - xqTitlesViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y: xqTitlesViewH  , width:xqScreenW, height:downContentH)
        //2.确定子控制器
        var childVcs = [DNFSubViewController]()
        for type in homeTypes {
            let anchorVC = DNFSubViewController()
            anchorVC.home = type
            childVcs.append(anchorVC)
        }
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.collectionView.isScrollEnabled = false
        return pageContentView
    }()
    private func loadTypesData() ->[HomeStyle] {
        let path = Bundle.main.path(forResource: "DNF", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!) as? [[String: Any]] ?? []
        var tempArray = [HomeStyle]()
        for dict in dataArray {
            tempArray.append(HomeStyle(dict:dict))
        }
        return tempArray
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(DNFDownTitileView)
        view.addSubview(pageContentView)
        view.insertSubview(pageContentView, belowSubview: DNFDownTitileView)
    }
}
//遵守pageTitleViewDelegate协议
extension DNFBrocastViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
