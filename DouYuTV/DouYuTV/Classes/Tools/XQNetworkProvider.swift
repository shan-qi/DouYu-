//
//  XQNetworkProvider.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/14.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
import Moya
import Result
import SwiftyJSON
import ObjectMapper

//成功

typealias SuccessClosure = (_ result : String) -> Void
typealias SuccessModelClosure = (_ result : Mappable?) -> Void
typealias SuccessArrayModelClosure = (_ result : [Mappable]?) -> Void
typealias SuccessJSONClosure = (_ result : JSON) -> Void
//失败
typealias FailClosure = (_ result : String?) -> Void

class XQNetworkProvider {
    //共享实例
    static let sharedInstance = XQNetworkProvider()
    private init(){}
    private let failInfo = "数据解析失败"
    
    
    
    //pragma mark: -请求JSON数据
    
    func requestDataWithJsonClosure<T:TargetType>(target:T,successClosure: @escaping SuccessJSONClosure,
                                          failClosure : @escaping FailClosure){
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
//        let _ = requestProvider.request(target) { (result) in
//            switch res
//        }
        let _ = requestProvider.request(target) { (result)  in
            switch result{
            case let .success(response):
                do{
                    let mapJson = try response.mapJSON()
                    let json = JSON(mapJson)
                    guard let _ = json.dictionaryObject else{
                        failClosure(self.failInfo)
                        return
                    }
                    successClosure(json["data"])
                }catch{
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                    failClosure(error.errorDescription)
            }
        }
    }
    
    
    //设置一个公共的请求超时时间
    private func requestTimeoutClosure<T:TargetType>(target:T) -> MoyaProvider<T>.RequestClosure{
        let requestTimeoutClosure = { (endPoint:Endpoint<T>, done : @escaping MoyaProvider.RequestResultClosure) in
            do {
                var request = try endPoint.urlRequest()
                request.timeoutInterval = 20
                done(.success(request))
            }catch {
                return
            }
        }
        return requestTimeoutClosure
    }
    

}
