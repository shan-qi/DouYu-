//
//  MainViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/20.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        setupUI()
    }
}
extension MainViewController{
    fileprivate func setupUI() {
        let array = [
            ["clsName": "HomeViewController", "title": "直播", "imageName": "tabLive"],
            ["clsName": "VideoViewController", "title": "娱乐", "imageName": "tabYule"],
            ["clsName": "FollowViewController", "title": "关注", "imageName": "tabFocus"],
            ["clsName": "FishbarViewController", "title": "鱼吧", "imageName": "tabYuba"],
            ["clsName": "DiscoveryViewController", "title": "发现", "imageName": "tabDiscovery"],
            ]
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(setupViewControllers(dict as [String : Any]))
        }

        viewControllers = arrayM
    }
    private func setupViewControllers(_ dict:[String : Any]) -> UIViewController {
        // 1.取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? BaseViewController.Type else {
                return UIViewController()
        }
        // 2.创建控制器
        let vc = cls.init()
        vc.title = title
        //3.设置头像
        vc.tabBarItem.image = UIImage(named:imageName)
        vc.tabBarItem.selectedImage = UIImage(named:imageName + "HL")?.withRenderingMode(.alwaysOriginal)

        //4. 设置 tabbar 的标题字体（大小）
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .selected)
        // 系统默认是 12 号字，修改字体大小，要设置 Normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = XQNavViewController(rootViewController: vc)
        return nav

    }
}

