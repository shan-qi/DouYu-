//
//  XQClassifyViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
import SwiftyJSON
import ESPullToRefresh


private let itemH = xqScreenW / 4
class XQClassifyViewController: BaseViewController {
    
    var cateOneList : Array<JSON> = []
    private var recommendCateData : XQRecomCateData?
    private var cateListData : [XQCateOneData] = [XQCateOneData]()
    
    private lazy var mainTable : UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: xqScreenH-xqStatusBarH-xqBarbarH-xqNavigationH), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //设置 footerView的高度为0
        tableView.sectionFooterHeight = 0
        tableView.backgroundColor = kWhite
        tableView.register(XQCategoryListCell.self, forCellReuseIdentifier: XQCategoryListCell.identifier())
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kWhite
        setUpAllView()
        //分类获取列表数据
        loadCateListData()
        
        XQProgressHUD.showProgress(superView: self.view, bgFrame: CGRect(x: 0, y: 0, width: xqScreenW, height: xqScreenH-xqStatusBarH-xqBarbarH-xqNavigationH), imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
    }
    
    //列表滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if offSetY > 120 {
            NotificationCenter.default.post(name: Notification.Name(XQNotiRefreshHomeNavBar), object: nil, userInfo:kNavBarHidden)
        }else{
            NotificationCenter.default.post(name: Notification.Name(XQNotiRefreshHomeNavBar), object: nil, userInfo: kNavBarNotHidden)
        }
    }
}
extension XQClassifyViewController{
    private func loadCateListData(){
        
        let semaphoreA = DispatchSemaphore(value: 1)
        let semaphoreB = DispatchSemaphore(value: 0)
        let semaphoreC = DispatchSemaphore(value: 0)
        
        
        let queue = DispatchQueue(label: "douyu.queue", qos: .utility, attributes: .concurrent)
        
        
        queue.async {
            semaphoreA.signal()
            
            XQNetworkProvider.sharedInstance.requestDataWithJsonClosure(target: HomeAPI.liveCateList, successClosure: { (response) in
                
                guard let jsonDic = response.dictionaryObject else{
                    semaphoreB.signal()
                    return
                }
                //字典转模型
                let allData : XQCateAllData = XQCateAllData(JSON: jsonDic)!
                self.cateListData = allData.cate1_list
                semaphoreB.signal()
            }, failClosure: { (_) in
                semaphoreB.signal()
            })
        }
        queue.async {
            semaphoreB.wait()
            
            XQNetworkProvider.sharedInstance.requestDataWithJsonClosure(target: HomeAPI.recommendCategoryList, successClosure: { (response) in
                guard let jsonDic = response.dictionaryObject else{
                    semaphoreC.signal()
                    return
                }
                let recommendData : XQRecomCateData = XQRecomCateData(JSON: jsonDic)!
                self.recommendCateData = recommendData
                semaphoreC.signal()
            }, failClosure: { (_) in
                semaphoreC.signal()
            })
        }
        queue.async {
            if semaphoreC.wait(wallTimeout: .distantFuture) == .success{
                DispatchQueue.main.async {
                    self.mainTable.es.stopPullToRefresh()
                    XQProgressHUD.hideAllHUD()
                    self.mainTable.reloadData()
                }
            }
        }
    }
}
//pragma mark: -配置UI
extension XQClassifyViewController  {
   private func setUpAllView(){
        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        var header : ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = XQRefreshView(frame: CGRect.zero)
        self.mainTable.es.addPullToRefresh(animator: header) {[weak self] in
            self?.loadCateListData()
        }
    }
}

extension XQClassifyViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (self.cateListData.count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XQCategoryListCell.identifier(), for: indexPath) as! XQCategoryListCell
        
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.cateTwoList = self.recommendCateData?.cate2_list
        }else{
            if self.cateListData.count != 0{
                let item = self.cateListData[indexPath.section - 1]
                cell.cateTwoList = item.cate2_list
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard self.cateListData.count != 0 else {return 0}
        let maxItemCount = 12
        let pageControlHeight : CGFloat = 37
        let spaceHeight : CGFloat = 10 //没有pageControl时添加
        var dataCount = 0 //item的数量
        
        if indexPath.section == 0 {
            let model = self.recommendCateData?.cate2_list ?? []
            dataCount = model.count
        }else{
            let model = self.cateListData[indexPath.section - 1].cate2_list
            dataCount = model.count
        }
        
        //根据item的个数计算cell的高度
        if dataCount > maxItemCount {
            return CateItemHeight * 3 + pageControlHeight
        }else if dataCount > 4 && dataCount <= maxItemCount{
            return CateItemHeight * 3 + spaceHeight
        }else{
            return CateItemHeight + spaceHeight
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = XQCollectionHeaderView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: Adapt(50)))
        
        if section == 0 {
            headerView.configTitle(title: "推荐分类")
        }else{
            if self.cateListData.count != 0{
                let item = self.cateListData[section - 1]
                headerView.configTitle(title: item.cate_name!)
            }
            
        }
        headerView.topLine.isHidden = true
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Adapt(50)
    }
}
