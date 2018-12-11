//
//  BaseViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/3/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //定义属性
    var contentView : UIView?
    //pragma mark: -懒加载
    fileprivate lazy var animationImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"dyla_img_loading_000"))
        imageView.center = self.view.center
        imageView.animationImages = getloadingImages()
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    fileprivate lazy var loadLabel : UILabel = {
       let loadLabel = UILabel()
        loadLabel.text = "加载中..."
        loadLabel.textColor = UIColor.darkGray
        loadLabel.font = UIFont.systemFont(ofSize: 15.0)
        loadLabel.frame = CGRect(x: self.animationImageView.frame.origin.x + 50, y:self.animationImageView.frame.origin.y + 100 , width: 100, height: 40)
        return loadLabel
    }()
    
    //pragma mark: -系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}
//pragma mark: -设置UI界面
extension BaseViewController{
    @objc func setupUI(){
        //1.隐藏底部内容
        self.contentView?.isHidden = true
        //2.将animationImageView添加进去
        view.addSubview(animationImageView)
        //3.将loadLabel添加进去
        view.addSubview(loadLabel)
        //4.给animationImageView执行动画
        animationImageView.startAnimating()
        //5.设置View的背景颜色
        view.backgroundColor = UIColor.white
    }
}
extension BaseViewController {
    func loadDataFinished(){
        //1.将animationImageView停止动画
        animationImageView.stopAnimating()
        //2.隐藏animationImageView
        animationImageView.isHidden = true
        //3.隐藏loadLabel
        loadLabel.isHidden = true
        //4.显示contentView
        contentView?.isHidden = false
    }
}
extension BaseViewController{
    // 配置 NavigationBar
    func setUpNavigation(){
        // 修改状态栏背景颜色
        self.navigationController?.navigationBar.barTintColor = kMainOrangeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // 左边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn_user_normal"), style:.done ,target: self, action: #selector(self.leftItemClick))
        // 右边的按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "viewHistoryIcon"), style:.done, target: self, action: #selector(self.rightItemClick))
        let searchView  = XQHomeSearchView()
        searchView.layer.cornerRadius = 5
        searchView.backgroundColor = kSearchBGColor
        navigationItem.titleView = searchView
        searchView.snp.makeConstraints { (make) in
            make.center.equalTo((navigationItem.titleView?.snp.center)!)
            make.width.equalTo(AdaptW(230))
            make.height.equalTo(33)
        }
    }    
    @objc func rightItemClick() {
        // ZJPopupView 自定义视图
        //        let customView = ZJCustomView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //        let popView = ZJPopupView(size: CGSize(width: 250, height: 200),customView: customView , style: .ZJPopTransition)
        //        popView.zj_showPopView()
    }
    
    @objc func leftItemClick() {
                self.navigationController?.pushViewController(MineViewController(), animated: true)
    }
}

