//
//  WholeArnyViewModel.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class WholeArmyViewModel: BaseViewModel {
    private var count : Int = 0
}
extension WholeArmyViewModel{
    //pragma mark: -下拉刷新
    func requestData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.wholeArmyID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -上拉加载
    func requestMoreData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count += 20
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.wholeArmyID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -顶部滚动图片
    func requestCyclePictureData(_ finishCallback : @escaping () -> ()){
        requestCyclePicture(urlString: "https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=349&app_ver=\(app_ver)&client_sys=ios", method: .get, finishedCallBack: finishCallback)
    }
}
