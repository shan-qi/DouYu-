//
//  TotalViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class TotalViewModel: BaseViewModel {
    private var count : Int = 0
}
extension TotalViewModel{
    func requestData(_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlist/0_0/0/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        }
}
extension TotalViewModel{
    func loadData(_ finishCallback : @escaping ()->()){
        count += 20
         let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlist/0_0/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(count)
    }
}
 
    

