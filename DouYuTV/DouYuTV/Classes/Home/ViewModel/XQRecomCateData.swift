//
//  XQRecomCateData.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
import  ObjectMapper



class XQRecomCateData: Mappable {
    
    var total : Int?
    var cate2_list : [XQRecomCateList] = [XQRecomCateList]()
    var error : Int?
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total  <- map["total"]
        error  <- map["error"]
        cate2_list <- map["cate2_list"]
    }
}
class XQRecomCateList: Mappable {
    var cate2_name : String?
    var small_icon_url : String?
    var is_vertical : Int?
    var icon_url : String?
    var cate2_id : Int?
    var cate2_short_name : String?
    var push_nearby : Int?
    var square_icon_url : String?
    
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate2_name <- map["cate2_name"]
        small_icon_url <- map["small_icon_url"]
        is_vertical <- map["is_vertical"]
        icon_url <- map["icon_url"]
        cate2_id <- map["cate2_id"]
        cate2_short_name <- map["cate2_short_name"]
        push_nearby <- map["push_nearby"]
        square_icon_url <- map["square_icon_url"]
    }
}

class XQCateAllData: Mappable {
    
    var cate1_list : [XQCateOneData] = [XQCateOneData]()
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate1_list  <- map["cate1_list"]
    }
}

class XQCateOneData: Mappable {
    
    var cate1_id : Int?
    var cate_name : String?
    var cate2_count : Int?
    var cate2_list : [XQRecomCateList] = [XQRecomCateList]()
    init(){
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cate1_id  <- map["cate1_id"]
        cate_name  <- map["cate_name"]
        cate2_count  <- map["cate2_count"]
        cate2_list <- map["cate2_list"]
    }
}

