//
//  LOLViewModel.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/26.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class LOLViewModel: BaseViewModel {
    private var count : Int = 0
    lazy var lolGameModels : [ClassifyModel] = [ClassifyModel]()
}

extension LOLViewModel{
    //pragma mark: -下拉刷新
    func requestData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.lolID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        
    }
    //pragma mark: -上拉加载
    func requestMoreData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count += 20
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.lolID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -顶部滚动图片
    func requestCyclePictureData(_ finishCallback : @escaping () -> ()){
        requestCyclePicture(urlString: "https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=1&app_ver=\(app_ver)&client_sys=ios", method: .get, finishedCallBack: finishCallback)
    }
    
    //pragma mark: -推荐左右滚动数据
    
    //pragma mark: -按英雄的种类
    func requestLolGameData(_ finishCallback : @escaping () -> ()){
        NetworkTools.requestData(urlString: "https://apiv2.douyucdn.cn/Live/Wzry/getAllTag2List?cate2_id=1&cache=4.6.0&client_sys=ios", type: .get) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            
            for dic in dataArray{
                self.lolGameModels.append(ClassifyModel(dict: dic))
            }
            finishCallback()
        }
    }
    //pragma mark: -请求英雄分类
    func requestHeroData(_ finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: "https://apiv2.douyucdn.cn/Live/Wzry/getAllTag1WithTag2List?cate2_id=1&cache=4.6.0&client_sys=ios", type: .get) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            for dict in dataArray{
                self.anchorClassifyModel.append(AnchorClassifyModel(dict: dict))
            }
            finishedCallBack()
        }
    }
    
}
