//
//  NetworkTools.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}
class NetworkTools {
    class func requestData(urlString : String , type:MethodType ,parameters:[String : Any]? = nil,headers:[String : String]?=nil ,finishedCallBack: @escaping(_ result : Any)->()){
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            guard  let  result = response.result.value else{
                print(response.result.error ?? 0)
                return
            }
            finishedCallBack(result)
        }
    }
}


