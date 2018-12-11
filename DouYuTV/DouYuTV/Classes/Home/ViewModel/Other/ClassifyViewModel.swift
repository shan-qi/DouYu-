//
//  ClassifyViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class ClassifyViewModel: BaseViewModel {
}
extension ClassifyViewModel{
    //1.请求推荐分类
    func requestRecommendClassify(_ finishCallback : @escaping () -> ()){
        //0.定义参数
       let myQueue = DispatchQueue(label: "myQueue")
       let parameters = ["client_sys":"ios"]
        myQueue.sync {
            self.requestClassifyData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/live/cate/getLiveRecommendCate2", method: .get
                , parameters: parameters, finishedCallBack: finishCallback)
        }
        myQueue.sync {
            self.requestOtherClassifyData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/live/cate/getLiveCate1List", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        }
    }
    func requestVideoClassify(_ finishCallback : @escaping () -> ()){
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestKingHeroData(urlString: "http://apiv2.douyucdn.cn/Video/cate/getVideoAllCate", method: .get, parameters:parameters , finishedCallBack: finishCallback)
    }
}
