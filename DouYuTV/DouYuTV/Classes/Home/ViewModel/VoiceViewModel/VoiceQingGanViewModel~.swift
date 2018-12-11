//
//  VoiceQingGanViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/13.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class VoiceQingGanViewModel: BaseViewModel {

}
extension VoiceQingGanViewModel{
    func requestData(_ finishCallback : @escaping () -> ()){
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_405/0/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
}
