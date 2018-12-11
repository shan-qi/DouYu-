//
//  MineViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class MineViewController: UITableViewController {
    
    //pragma mark: -存储plist文件中的数据
    var sections : NSArray?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let path = Bundle.main.path(forResource: "minePlist", ofType: "plist")
        sections = NSArray(contentsOfFile: path!)
        setUpAllView()
        
        //显示加载动画
        XQProgressHUD.showProgress(superView: UIApplication.shared.keyWindow!, bgFrame: CGRect(x: 0, y: 0, width: xqScreenW, height: xqScreenH), imgArr: getloadingImages(), timeMilliseconds: 90, bgColor: kWhite, scale: 0.8)
        //延迟1秒隐藏加载动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XQProgressHUD.hideAllHUD()
        }
    }
    
    private func setUpAllView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navBackBtn"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(self.leftItemBackClick))
        
        //直播按钮
        let liveBtn = UIButton(frame:CGRect(x:0, y:0, width:20, height:20))
        liveBtn.setImage(UIImage(named: "icon_nav_dycard"), for: .normal)
        liveBtn.addTarget(self,action:#selector(self.leftItemBackClick),for:.touchUpInside)
        let barButton1 = UIBarButtonItem(customView: liveBtn)
        //设置按钮
        let setBtn = UIButton(frame:CGRect(x:0, y:0, width:20, height:20))
        setBtn.setImage(UIImage(named: "Image_headerView_settings"), for: .normal)
        setBtn.addTarget(self,action:#selector(self.settingAction),for:.touchUpInside)
        let barButton2 = UIBarButtonItem(customView: setBtn)
        
        //按钮间的空隙
        let gap = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                  action: nil)
        gap.width = 15
        
        //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10
        //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [spacer,barButton2,gap,barButton1]
    }
    
    /// 懒加载 头部
    private lazy var headerView = LoginHeaderView.loadViewFromNib()
    //pragma mark: -登录弹窗
    private lazy var loginView : XQPopLoginView = {
        let  loginView = XQPopLoginView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: xqScreenH))
        loginView.delegate = self
        return loginView
    }()
    
}
extension MineViewController{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  10
    }
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: 10))
        headerView.backgroundColor = UIColor.init(hex: "#f6f6f6", alpha: 1.0)
        return headerView
    }
    // 行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    // 组数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    // 每组的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.sections![section] as! Array<AnyObject>
        
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as MineTableViewCell
        let data = self.sections?[indexPath.section] as! Array<AnyObject>
        cell.titleLabel.text = data[indexPath.row]["title"] as? String
        cell.titleImage.image = UIImage(named: data[indexPath.row]["avatar"] as! String)
        cell.rightLabel.text = data[indexPath.row]["rightTitle"] as? String
        return cell
    }
}
extension MineViewController{
    fileprivate func setupUI(){
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.ym_registerCell(cell: MineTableViewCell.self)
        //登录弹窗
        headerView.deleagte = self
    }
}
extension MineViewController : XQPopLoginViewDelegate{
    func xq_goToLoginVC() {
        
    }
    func xq_goToRegisterVC() {
        
    }
}
extension MineViewController : LoginHeaderViewDelegate{
    func xq_loginBtnAction(sender: UIButton) {
        UIApplication.shared.keyWindow?.addSubview(self.loginView)
        self.loginView.xq_showLoginView()
    }
}
extension MineViewController{
    @objc private func leftItemBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func settingAction() {
        self.navigationController?.pushViewController(SettingTableViewController(), animated: true)
    }
}
