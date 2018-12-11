//
//  BaseViewModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewModel: NSObject {
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var dynamicModel : [DynamicModel] = [DynamicModel]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    lazy var classifyModel : [ClassifyModel] = [ClassifyModel]()
    lazy var anchorClassifyModel : [AnchorClassifyModel] = [AnchorClassifyModel]()
    lazy var recommendModels : [CycleModel] = [CycleModel]()
    lazy var recommendGameModels : [ClassifyModel] = [ClassifyModel]()
//    var anchorModel : AnchorModel?
    lazy var anchorModel : [AnchorModel] = [AnchorModel]()
}
extension BaseViewModel{
    func requestAnchorData(isGroupData : Bool, urlString : String,method : MethodType, parameters : [String : Any]? = nil , finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: method, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            guard let list = dataArray["list"] as? [[String : Any]] else {return}
            for video in list{
                self.anchorModel.append(AnchorModel(dict: video))
            }
            
            
            if isGroupData{
                // 2.1遍历数组中的字典
                self.anchorGroups.append(AnchorGroup(dict: dataArray))
            }else{
                //2.1创建组
                let group = AnchorGroup()
                //遍历数组字典
                group.anchors.append(AnchorModel(dict: dataArray))
                self.anchorGroups.append(group)
            }
            // 3.完成回调
            finishedCallBack()
        }
    }
}
extension BaseViewModel{
    func requestDynamicData(isGroupData : Bool, urlString : String,method : MethodType, parameters : [String : Any]? = nil ,headers: [String : String]? = nil, finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: method, parameters: parameters, headers: headers) { (result) in
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            guard let list = dataArray["list"] as? [[String : Any]] else {return}
            for dict in list{
                self.dynamicModel.append(DynamicModel(dict: dict))
            }
            finishedCallBack()
        }
    }
}
extension BaseViewModel{
    
    func requestRecommend(isGroupData : Bool,urlString:String,method:MethodType,parameters : [String : Any]? = nil , finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: .get, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            if isGroupData{
                for dic in dataArray{
                    self.anchorGroups.append(AnchorGroup(dict: dic))
                }
            }else{
            // 2.1遍历数组中的字典
            let group = AnchorGroup()
            for dict in dataArray{
                group.anchors.append(AnchorModel(dict: dict))
            }
            self.anchorGroups.append(group)
            // 3.完成回调
            }
            finishedCallBack()
        }
    }
}
//pragma mark: -获取滚动图片
extension BaseViewModel {
    func requestCyclePicture(urlString:String,method:MethodType,finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString:urlString, type:method) { (result)in
            guard  let resultDic = result as? [String : Any] else {return}
            let data = resultDic["error"] as? Int
            if data == 0 {
                guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
                guard let  slide_list = dataArray["slide_list"]  as? [[String : Any]]else {return}
                for dic in slide_list{
                    self.cycleModels.append(CycleModel(dict: dic))
                }
            }
            finishedCallBack()
        }
    }
}
//pragma mark: -请求分类数据
extension BaseViewModel {
    func requestClassifyData(isGroupData : Bool, urlString : String,method : MethodType, parameters : [String : Any]? = nil , finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: method, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            if isGroupData{
                // 2.1遍历数组中的字典
            self.anchorClassifyModel.append(AnchorClassifyModel(dict: dataArray))
            }else{
                //2.1创建组
                let group  =  AnchorClassifyModel()
                //遍历数组字典
                group.classify.append(ClassifyModel(dict: dataArray))
                self.anchorClassifyModel.append(group)
            }
            // 3.完成回调
            finishedCallBack()
        }
    }
    func requestKingHeroData(urlString : String,method : MethodType, parameters : [String : Any]? = nil , finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: method, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [[String : Any]] else {return}
                for dict in dataArray{
                self.anchorClassifyModel.append(AnchorClassifyModel(dict: dict))                
            }
            finishedCallBack()
        }
    }
    func requestOtherClassifyData(isGroupData : Bool, urlString : String,method : MethodType, parameters : [String : Any]? = nil , finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: method, parameters: parameters) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [String : Any] else {return}
            guard let cate1_list = dataArray["cate1_list"] as? [[String : Any]] else{return}
            
            for dict in cate1_list{
                if isGroupData{
                    // 2.1遍历数组中的字典
                    self.anchorClassifyModel.append(AnchorClassifyModel(dict: dict))
                }else{
                    //2.1创建组
                    let group  =  AnchorClassifyModel()
                    //遍历数组字典
                    group.classify.append(ClassifyModel(dict: dict))
                    self.anchorClassifyModel.append(group)
                }
            }
            // 3.完成回调
            finishedCallBack()
        }
    }
}
//pragma mark: -上下滚动数据
extension BaseViewModel{
    func requestUpAndDownData(urlString:String,method:MethodType,finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type:method) { (result) in
            guard let resultDic = result as? [String : Any] else {return}
            let data = resultDic["error"] as? Int
            if data == 0 {
                guard let dataArray = resultDic["data"] as? [String : Any] else {return}
                guard let list = dataArray["list"] as? [[String : Any]] else{return}
                for dic in list {
                    self.recommendModels.append(CycleModel(dict: dic))
                }
            }
            finishedCallBack()
        }
    }
}
//pragma mark: -左右游戏滑动数据
extension BaseViewModel{
    func requestLeftAndRightData(urlString:String,method:MethodType,finishedCallBack : @escaping () -> ()){
        NetworkTools.requestData(urlString: urlString, type: method) { (result) in
            // 1.对结果进行处理
            guard  let resultDic = result as? [String : Any] else {return}
            guard  let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            for dic in dataArray{
                self.recommendGameModels.append(ClassifyModel(dict: dic))
            }
            finishedCallBack()
        }
    }
}


