//
//  SportViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/8.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SportViewModel: BaseViewModel {
    var count = 0
}
extension SportViewModel{
    //pragma mark: -下拉刷新数据
    func requestData(_ finishCallback : @escaping () -> ()){
        //0.定义参数
        requestRecommend(isGroupData: false, urlString: "http://capi.douyucdn.cn/api/v1/qie?limit=20", method: .get, parameters:["client_sys":"ios","offset":"0"], finishedCallBack: finishCallback)
    }
    //pragma mark: -上拉加载数据
    func loadData(_ finishCallback : @escaping ()->()){
        count += 20
        //0.定义参数
        requestRecommend(isGroupData: false, urlString: "http://capi.douyucdn.cn/api/v1/qie?limit=20", method: .get, parameters:["client_sys":"ios","offset":"\(count)"], finishedCallBack: finishCallback)
    }
    
}
