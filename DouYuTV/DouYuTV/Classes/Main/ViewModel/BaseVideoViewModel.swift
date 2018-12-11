//
//  BaseVideoViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/6/9.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class BaseVideoViewModel: BaseViewModel {
     private var offset : Int = 0
}
//pragma mark: -下拉刷新
extension BaseVideoViewModel{
    //pragma mark: -视频推荐
    func requesRecData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"0","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -刺激战场
    func requesStimulatetData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"138","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -王者荣耀
    func requestKingData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"49","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -绝地求生
    func requestSurvivalData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"104","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -英雄联盟
    func requestLOLData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"5","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -主机游戏
    func requestHostGameData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"103","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -QQ飞车
    func requestQQFlyingCarData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"134","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -全军出击
    func requestWholeArmyData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"137","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -DOTA2
    func requestDOTA2Data(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"6","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -炉石传说
    func requestHeartStoneData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"8","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -DNF
    func requestDNFData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"94","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    //pragma mark: -CF手游
    func requestCFData(_ finishCallback : @escaping () -> ()){
        offset = 0
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"139","action":"hot"]
        //0.定义参数
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
    }
    
}
//pragma mark: -上拉加载
extension BaseVideoViewModel{
    //pragma mark: -视频推荐
    func requesRecMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"0","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -刺激战场
    func requesStimulatetMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"138","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -王者荣耀
    func loadKingMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"49","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -绝地求生
    func loadSurvivalMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"104","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -英雄联盟
    func loadLOLMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"5","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -主机游戏
    func loadHostGameMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"103","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -QQ飞车
    func loadQQFlyingCarMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"134","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -全军出击
    func loadWholeArmyMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"137","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -DOTA2
    func loadDOTA2MoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"6","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -炉石传说
    func loadHeartStoneMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"8","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -DNF
    func loadDNFMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"94","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
    //pragma mark: -CF手游
    func loadCFMoreData(_ finishCallback : @escaping ()->()){
        offset += 10
        let parameters = ["limit":"10","offset":"\(offset)","client_sys":"ios","cate2_id":"139","action":"hot"]
        requestAnchorData(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/Video/caterecom/getVideoCateList", method: .get, parameters: parameters, finishedCallBack: finishCallback)
        print(offset)
    }
}
