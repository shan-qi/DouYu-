//
//  RecommendGameDataViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/6.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let xqTitlesViewH : CGFloat = 50
class RecommendGameDataViewController: UIViewController{
    
    var editBtn = UIButton(type: .custom)
    var flag : Bool = false
    //懒加载属性(pageTitileView)
    private lazy var pageTitleView : PageSubTitleView = {
        let homeTypes = loadTypesData()
        let titles = homeTypes.map({$0.title})
        let style = XQTitleStyle()
        style.font = UIFont.systemFont(ofSize: 18.0)
        style.isShowBottomLine = false
        let pageFrame = CGRect(x: 0, y: 50, width: xqScreenW, height: xqTitlesViewH)
        let titlesView = PageSubTitleView(frame: pageFrame, titles: titles, style: style)
        titlesView.delegate = self
        return titlesView
    }()
    //懒加载属性(PageContentView)
    private lazy var pageContentView : PageContentView = {
        let homeTypes = loadTypesData()
        //1.确定内容的frame
        let pageContentH : CGFloat = xqScreenH - xqTitlesViewH  - xqBarbarH
        let pageFrame = CGRect(x: 0, y: 50 + xqTitlesViewH  , width:xqScreenW, height:pageContentH)
        //2.确定子控制器
        var childVcs = [RecommendSubViewController]()
        for type in homeTypes {
            let anchorVC = RecommendSubViewController()
            anchorVC.home = type
            childVcs.append(anchorVC)
        }        
        let pageContentView = PageContentView(frame:pageFrame, childVcs: childVcs, parentViewContrller: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    private func loadTypesData() ->[HomeStyle] {
        let path = Bundle.main.path(forResource: "ClassifyMore", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!) as? [[String: Any]] ?? []
        var tempArray = [HomeStyle]()
        for dict in dataArray {
            tempArray.append(HomeStyle(dict:dict))
        }
        return tempArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NaviItem()
        showRightBarItem()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func NaviItem(){
        //隐藏系统的导航栏 不然点击事件受到影响
        self.navigationController?.isNavigationBarHidden=true
        // 创建一个导航栏
        let navBar = XQNavigationBar(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:50))
        navBar.backgroundColor = UIColor.white
        let leftBtn = UIButton(type: .custom)
        leftBtn.addTarget(self, action: #selector(popToParent), for: .touchUpInside)
        leftBtn.frame = CGRect(x: -40, y: 0, width: 120, height: 40)
        leftBtn.setTitle("更多", for: .normal)
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right:0 )
        navBar.setNavigationBar(titleText: "", font: UIFont.systemFont(ofSize: 20), leftBtn: leftBtn, leftImage: UIImage(named: "navBackBtn_new_HL")!)
        // 导航栏添加到view上
        self.view.addSubview(navBar)
    }
    @objc func popToParent(){
        navigationController?.popViewController(animated: true)
    }
    
}
extension RecommendGameDataViewController{
    func showRightBarItem(){
        let editView = UIView()
        editView.frame = CGRect(x: 0, y: 20, width: 44, height: 30)
        editBtn.setTitle("编辑", for: .normal)
        editBtn.setTitleColor(UIColor.darkGray, for: .normal)
        editBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        editBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        editBtn.addTarget(self, action: #selector(rightBarClick), for: .touchUpInside)
        editView.addSubview(editBtn)
        //这里可以添加一个编辑
        let rightBarBtn:UIBarButtonItem = UIBarButtonItem.init(customView: editView)
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    @objc func rightBarClick() {
        if !flag {
            flag = true
            editBtn.setTitle("完成", for: .normal)
        }else{
            flag = false
            editBtn.setTitle("编辑", for: .normal)
        }
    }
}
//遵守pageTitleViewDelegate协议
extension RecommendGameDataViewController : pageSubTitleViewDelegate{
    func pageSubTitleView(_ titleView: PageSubTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}
//遵守pageContentViewDelegate协议
extension RecommendGameDataViewController : pageContentViewDelegate{
    func contentViewEndScroll(_ contentView: PageContentView) {
        pageTitleView.contentViewDidEndScroll()
    }
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


