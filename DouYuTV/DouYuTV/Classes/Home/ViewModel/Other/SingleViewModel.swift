//
//  SingleViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SingleViewModel: BaseViewModel {
    private var count : Int = 0
}
extension SingleViewModel{
    func requestData(_ finishCallback : @escaping ()->()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_15/0/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
}
extension SingleViewModel{
    func loadData(_ finishCallback : @escaping ()->()){
        count += 20
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_15/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(count)
    }
}
extension SingleViewModel {
    func loadGameData(_ finishCallback : @escaping ()->()){
        NetworkTools.requestData(urlString: "https://apiv2.douyucdn.cn/live/Cate/getTabCate2List?tab_id=3&client_sys=ios", type: .get) { (result) in
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
