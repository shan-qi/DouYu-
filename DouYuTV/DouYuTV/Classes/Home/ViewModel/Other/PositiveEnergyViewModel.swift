//
//  PositiveEnergyViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/4.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class PositiveEnergyViewModel: BaseViewModel {
    private let parameters = ["client_sys":"ios"]
}
extension PositiveEnergyViewModel{
    //pragma mark: -下拉刷新数据
    func requestData(_ finishCallback : @escaping () -> ()){
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_13/0/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -上拉加载数据
    func loadData(_ finishCallback : @escaping ()->()){
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_13/20/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
}
