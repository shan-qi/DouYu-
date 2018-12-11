//
//  ScienceViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class ScienceViewModel: BaseViewModel {
    private var count : Int = 0
    private let parameters = ["client_sys":"ios"]
}
extension ScienceViewModel{
    //pragma mark: -下拉刷新数据
    func requestData(_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_11/0/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -上拉加载数据
    func loadData(_ finishCallback : @escaping ()->()){
        count += 20
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_11/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(count)
    }
    func loadGameData(_ finishCallback : @escaping ()->()){
        NetworkTools.requestData(urlString: "https://apiv2.douyucdn.cn/live/Cate/getTabCate2List?tab_id=7&client_sys=ios", type: .get) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            guard  let cate2_list = dataArray["cate2_list"] as? [[String : Any]] else {return}
            for dic in cate2_list{
                self.classifyModel.append(ClassifyModel(dict: dic))
            }
            finishCallback()
        }
    }
}
