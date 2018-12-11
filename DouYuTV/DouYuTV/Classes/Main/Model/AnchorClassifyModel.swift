//
//  AnchorClassifyModel.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/1.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class AnchorClassifyModel: BaseModel {
    
    @objc var  cate2_list : [[String : NSObject]]?{
        didSet{
            guard  let list = cate2_list else {return}
            for dict in list{
                classify.append(ClassifyModel(dict: dict))
            }
        }
    }
    @objc var  tag2_list : [[String : NSObject]]?{
        didSet{
            guard  let list = tag2_list else {return}
            for dict in list{
                classify.append(ClassifyModel(dict: dict))
            }
        }
    }
    @objc var  child : [[String : NSObject]]?{
        didSet{
            guard  let list = child else {return}
            for dict in list{
                classify.append(ClassifyModel(dict: dict))
            }
        }
    }
    
   
    lazy var classify : [ClassifyModel] = [ClassifyModel]()
}
