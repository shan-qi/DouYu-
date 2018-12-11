//
//  FaceViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/8.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class HotViewModel: BaseViewModel {
    private var count : Int = 0
    private let parameters = ["client_sys":"ios"]
}
extension HotViewModel{
    func requestData(_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_8/0/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
}
extension HotViewModel{
    func loadData(_ finishCallback : @escaping ()->()){
        count += 20
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_8/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(count)
    }
}

