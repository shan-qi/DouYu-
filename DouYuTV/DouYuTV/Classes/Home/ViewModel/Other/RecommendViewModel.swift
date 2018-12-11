//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/3.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    let group = AnchorGroup()
    //1.懒加载创建组(推荐数据组)
    private  lazy var bigDataGroups : AnchorGroup = AnchorGroup()
    //2.懒加载创建组(颜值数据组)
    private lazy var prettyDataGroups : AnchorGroup = AnchorGroup()
    lazy var recommendMoreModel : [AnchorClassifyModel] = [AnchorClassifyModel]()
}
extension RecommendViewModel {
    //pragma mark: -下拉刷新数据
    func requestData(_ finishCallback : @escaping () -> ()){
        //0.定义参数
        let parameters = ["client_sys":"ios"]
        //1.创建group
        let disGroup = DispatchGroup()
        //2.请求第一部分的推荐数据
        disGroup.enter()
        //pragma mark: -热门推荐
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}

            // 2.1遍历数组中的字典
            for dict in dataArray{
                self.bigDataGroups.anchors.append(AnchorModel(dict: dict))
            }
            //3.3离开组
            disGroup.leave()
        }
        disGroup.enter()
        //pragma mark: -颜值
//        https://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_18/0/4/ios?client_sys=ios
        NetworkTools.requestData(urlString: "https://apiv2.douyucdn.cn/gv2api/rkc/roomlistV1/1_18/0/4/ios", type: .get, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            for room_list in dataArray{
                guard let room_list = room_list["room_list"] as? [[String
                    : Any]] else{return}
                    for dict in room_list{
                    self.prettyDataGroups.anchors.append(AnchorModel(dict: dict))
                    }
            }
            disGroup.leave()
        }
        
        disGroup.enter()
        //pragma mark: -绝地求生
        requestRecommend(isGroupData: true, urlString:  "http://apiv2.douyucdn.cn/gv2api/rkc/listforhome/270/0/4/ios", method: .get, parameters: parameters){
            disGroup.leave()
        }
        
        disGroup.enter()
        //pragma mark: -炉石传说
        requestRecommend(isGroupData: true, urlString:  "http://apiv2.douyucdn.cn/gv2api/rkc/listforhome/2/0/4/ios", method: .get, parameters: parameters){
            disGroup.leave()
        }
        disGroup.enter()
        //pragma mark: -刺激战场
        requestRecommend(isGroupData: true, urlString:  "http://apiv2.douyucdn.cn/gv2api/rkc/listforhome/350/0/4/ios", method: .get, parameters: parameters){
            disGroup.leave()
        }
        disGroup.enter()
        //pragma mark: -英雄联盟
        requestRecommend(isGroupData: true, urlString:  "http://apiv2.douyucdn.cn/gv2api/rkc/listforhome/1/0/4/ios", method: .get, parameters: parameters){
            disGroup.leave()
        }
        disGroup.enter()
        //pragma mark: -王者荣耀
        requestRecommend(isGroupData: true, urlString:  "http://apiv2.douyucdn.cn/gv2api/rkc/listforhome/181/0/4/ios", method: .get, parameters: parameters){
            disGroup.leave()
        }
        disGroup.enter()
        //pragma mark: -DOTA2
        requestRecommend(isGroupData: true, urlString:  "http://apiv2.douyucdn.cn/gv2api/rkc/listforhome/3/0/4/ios", method: .get, parameters: parameters){
            disGroup.leave()
        }
        //pragma mark: -依次顺序获取数据
        disGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.bigDataGroups, at: 0)
            self.anchorGroups.insert(self.prettyDataGroups, at: 1)
            finishCallback()
        }
    }
    //pragma mark: -推荐上下滚动数据
    func requestRecommendData(_ finishCallback : @escaping () -> ()){
        requestUpAndDownData(urlString: "https://apiv2.douyucdn.cn/Live/Subactivity/getActivityList?client_sys=ios&cid2=0", method: .get, finishedCallBack: finishCallback)

    }
    //pragma mark: -推荐左右滚动数据
    func requestRecommendGameData(_ finishCallback : @escaping () -> ()){
        NetworkTools.requestData(urlString: "http://apiv2.douyucdn.cn/live/cate/getLiveRecommendCate2", type: .get, parameters: ["client_sys":"ios"]) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            guard let cate2_list = dataArray["cate2_list"] as? [[String : Any]] else {return}
            for cate2_name in cate2_list{
                self.recommendGameModels.append(ClassifyModel(dict: cate2_name))
            }
           finishCallback()
        }
    }
    //pragma mark: -推荐轮播数据
    func requestRecommendPictureData(_ finishCallback : @escaping () -> ()){
        NetworkTools.requestData(urlString: "http://capi.douyucdn.cn/api/v1/slide/6?version=3.700&client_sys=ios", type: .get) { (result) in
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            for dic in dataArray{
                self.cycleModels.append(CycleModel(dict: dic))
            }
            finishCallback()
        }
    }
    func requestData(type: HomeStyle,_ finishCallback : @escaping () -> ()){
        NetworkTools.requestData(urlString: "http://apiv2.douyucdn.cn/live/Cate/getTabCate2List?tab_id=\(type.tab_id)&client_sys=ios", type: .get) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            self.recommendMoreModel.append(AnchorClassifyModel(dict: dataArray))
            finishCallback()
        }
    }
}
//pragma mark: -视频推荐模块
extension RecommendViewModel{
    func requestVideoRecData(_ finishCallback : @escaping () -> ()){
        requestRecommend(isGroupData: true, urlString: "http://apiv2.douyucdn.cn/video/video/getEntryModule", method: .get, parameters: ["client_sys":"ios"], finishedCallBack: finishCallback)
    }
}
