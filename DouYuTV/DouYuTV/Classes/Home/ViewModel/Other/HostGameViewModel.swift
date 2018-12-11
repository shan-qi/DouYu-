//
//  HostGameViewModel.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/8/27.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class HostGameViewModel: BaseViewModel {
    private var count : Int = 0
    private var page : Int = 1
    private let timeStamp = Date().timeIntervalSince1970
}
extension HostGameViewModel{
    //pragma mark: -下拉刷新
    func requestData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count = 0
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.hostGameID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -上拉加载
    func requestMoreData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        count += 20
        let parameters = ["client_sys":"ios"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/\(type.hostGameID)/\(count)/20/ios", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -顶部滚动图片
    func requestCyclePictureData(_ finishCallback : @escaping () -> ()){
        requestCyclePicture(urlString: "https://apiv2.douyucdn.cn/live/Slide/getSlideLists?cate_id=19&app_ver=\(app_ver)&client_sys=ios", method: .get, finishedCallBack: finishCallback)
    }
}

extension HostGameViewModel{
    func requestData(_ finishCallback : @escaping () -> ()){
        
        page = 1
        let parameters = ["page":"\(page)","pagesize":"20"]
        let headers = [
            "dy-device-id":"8ae5945f812f9c72f13aae6c00001521",
            "phone_model":" iPhone8,1",
            "client":" ios",
            "phone_system":" 11.3.1",
            "timestamp":" \(timeStamp)",
            "Accept":" application/vnd.mapi-yuba.douyu.com.4.0+json",
            "auth":" 78a3b8d0a16684e4f9458fa7542e4b3e",
            "Content-Type":" application/x-www-form-urlencoded",
            "Host":" mapi-yuba.douyu.com",
            "Connection":" keep-alive",
            "Accept-Encoding":" gzip, deflate",
            "Accept-Language":"zh-Hans-CN;q=1",
            "User-Agent":"DYZB/4.800 (iPhone; iOS 11.3.1; Scale/2.00)",
            "Cookie":"acf_did=8ae5945f812f9c72f13aae6c00001521; Hm_lvt_e99aee90ec1b2106afe7ec3b199020a7=1524837870,1527121607; dy_did=edc4c1b6909bded8c5ab7f2c00071501",
            "version":"351"
        ]
        requestDynamicData(isGroupData: true, urlString: "http://mapi-yuba.douyu.com/wb/v3/catefeed/19", method: .get, parameters:parameters, headers: headers, finishedCallBack: finishCallback)
    }
    
    func loadData(_ finishCallback : @escaping ()->()){
        page += 1
        let parameters = ["page":"\(page)","pagesize":"20"]
        let headers = [
            "dy-device-id":"8ae5945f812f9c72f13aae6c00001521",
            "phone_model":" iPhone8,1",
            "client":" ios",
            "phone_system":" 11.3.1",
            "timestamp":" \(timeStamp)",
            "Accept":" application/vnd.mapi-yuba.douyu.com.4.0+json",
            "auth":" 78a3b8d0a16684e4f9458fa7542e4b3e",
            "Content-Type":" application/x-www-form-urlencoded",
            "Host":" mapi-yuba.douyu.com",
            "Connection":" keep-alive",
            "Accept-Encoding":" gzip, deflate",
            "Accept-Language":"zh-Hans-CN;q=1",
            "User-Agent":"DYZB/4.800 (iPhone; iOS 11.3.1; Scale/2.00)",
            "Cookie":"acf_did=8ae5945f812f9c72f13aae6c00001521; Hm_lvt_e99aee90ec1b2106afe7ec3b199020a7=1524837870,1527121607; dy_did=edc4c1b6909bded8c5ab7f2c00071501",
            "version":"351"
        ]
        requestDynamicData(isGroupData: true, urlString: "http://mapi-yuba.douyu.com/wb/v3/catefeed/19", method: .get, parameters:parameters, headers: headers, finishedCallBack: finishCallback)
    }
}
