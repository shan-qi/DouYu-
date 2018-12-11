//
//  ClassifyAPI.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/14.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
import Moya

let HomeProvider = MoyaProvider<HomeAPI>()

public enum HomeAPI{
    case recommendCategoryList //分类推荐列表
    case liveCateList //分类列表
}
extension HomeAPI : TargetType{
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .recommendCategoryList:
            return URL(string: "https://apiv2.douyucdn.cn")!
        case .liveCateList:
            return URL(string: "https://apiv2.douyucdn.cn")!
        }
    }
    
    //请求路径
    public var path: String {
        switch self {
        case .recommendCategoryList:
            return "/live/cate/getLiveRecommendCate2"
        case .liveCateList:
            return "/live/cate/getLiveCate1List"
        }
    }
    
    //请求方法
    public var method : Moya.Method {
        switch self {
        case .recommendCategoryList:
            return .get
        case .liveCateList:
            return .get
        }
    }

    //请求参数
    public var task: Task {
        switch self {
        case .recommendCategoryList:
            var params : [String : String] = [:]
            params["client_sys"] = "ios"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .liveCateList:
            var params : [String : String] = [:]
            params["client_sys"] = "ios"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
    
    
    
}
