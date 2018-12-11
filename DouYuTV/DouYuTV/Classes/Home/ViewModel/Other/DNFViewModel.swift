//
//  DNFViewModel.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class DNFViewModel: BaseViewModel {
     private var count : Int = 0
    lazy var livingAnchorModels : [ClassifyModel] = [ClassifyModel]()
}
extension DNFViewModel{
    //pragma mark: -下拉刷新
    func requestData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.dnfID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -上拉加载
    func requestMoreData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count += 20
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.dnfID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -顶部滚动图片
    func requestCyclePictureData(_ finishCallback : @escaping () -> ()){
        requestCyclePicture(urlString: "https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=40&app_ver=\(app_ver)&client_sys=ios", method: .get, finishedCallBack: finishCallback)
    }
    //pragma mark: -正在直播的主播数据
    func requestLivingAnchorData(_ finishCallback : @escaping () -> ()){
        NetworkTools.requestData(urlString: "https://apiv2.douyucdn.cn/live/anchorrecom/anchors?offset=0&client_sys=ios&cate2_id=40&limit=10", type: .get) { (result) in
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [String : Any] else {return}
            guard let anchors = dataArray["anchors"] as? [[String : Any]] else {return}
            for dic in anchors{
                self.livingAnchorModels.append(ClassifyModel(dict: dic))
            }
            finishCallback()
        }
    }
}
