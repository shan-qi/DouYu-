//
//  XQNavViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/13.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class XQNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        //自定义导航栏背景颜色
        let naView = self.navigationBar.subviews.first
        guard naView != nil else {return}
        // 导航栏背景渐变
        xq_setUpGradientLayer(view: naView!, frame: CGRect(x: 0, y: 0, width: xqScreenW, height: xqStatusBarH+xqNavigationH), color: kGradientColors)
    }

    // 拦截 push 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            //跳转后隐藏
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: true)
    }
}



