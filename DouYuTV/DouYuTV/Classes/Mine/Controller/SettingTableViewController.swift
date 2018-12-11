//
//  SettingTableViewController.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/25.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
private let cellID = "cellID"
class SettingTableViewController: UITableViewController {

//    private lazy var navigationBar = MineNavigationBar.loadViewFromNib()
    //pragma mark: -存储plist文件中的数据
    var sections : NSArray?
    
    private lazy var settingDanmu : SettingDanmu = {
        let  settingDanmu = SettingDanmu.settingDanmu()
        settingDanmu.frame = CGRect(x: 20, y: 10, width: xqScreenW - 150, height: 20)
        return settingDanmu
    }()
    private lazy var settingSlider : SettingSlider = {
        let  settingSlider = SettingSlider.settingSlider()
        settingSlider.frame = CGRect(x: 20, y: -10, width: 284 , height: 35)
        return settingSlider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviItem()
        view.backgroundColor = UIColor.init(hex: "#f6f6f6", alpha: 1.0)
        let path = Bundle.main.path(forResource: "setting", ofType: "plist")
        sections = NSArray(contentsOfFile: path!)
        tableView.separatorStyle = .none
        tableView.ym_registerCell(cell: SettingCell.self)
        tableView.ym_registerCell(cell: SettingFirstCell.self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
extension SettingTableViewController{
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  10
    }
    // 行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3:
            switch indexPath.row{
            case 3:  return 80
            default:break
            }
        default:break
        }
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: 10))
        headerView.backgroundColor = UIColor.init(hex: "#f6f6f6", alpha: 1.0)
        return headerView
    }
    // 每组的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.sections![section] as! Array<AnyObject>
        
        return data.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.sections?[indexPath.section] as! Array<AnyObject>
        if indexPath.row == 0 {
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as SettingFirstCell
            cell.titleLabel.text = data[indexPath.row]["title"] as? String
            cell.avatarImageView.image = UIImage(named: data[indexPath.row]["avatar"] as! String)
            return cell
        }else{
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as SettingCell

            cell.titleLabel.text = data[indexPath.row]["title"] as? String
                cell.subtitleLabel.text = data[indexPath.row]["subtitle"] as? String
                cell.rightTitleLabel.text = data[indexPath.row]["rightTitle"] as? String
                cell.switchView.isHidden = data[indexPath.row]["isHiddenSwitch"] as! Bool
                cell.arrowImageView.isHidden = data[indexPath.row]["isHiddenRightArraw"] as! Bool
            let isHiddenSubtitle = data[indexPath.row]["isHiddenSubtitle"] as! Bool
            let isHiddenMiddleView = data[indexPath.row]["isHiddenMiddleView"] as! Bool
            
            if !isHiddenSubtitle {
                cell.subtitleLabelHeight.constant = 20
            }else{
                cell.subtitleLabelHeight.constant = 0
            }
            if !isHiddenMiddleView {
                cell.middleView.isHidden = false
            }else{
                cell.middleView.isHidden = true
            }
           
            switch indexPath.section {
            case 3:
                switch indexPath.row {
                case 1:
                    let  settingSlider1 = SettingSlider.settingSlider()
                    settingSlider1.frame = CGRect(x: 7, y: -10, width: 284 , height: 40)
                    cell.middleView.addSubview(settingSlider1)
                case 2:
                    cell.middleView.addSubview(settingSlider)
                case 3:
                    cell.subtitleLabelHeight.constant = 45
                    cell.middleView.addSubview(settingDanmu)
                default: break
                }
            case 4:
                switch indexPath.row {
                case 1:  cell.calculateDiskCashSize()// 清理缓存，从沙盒中获取缓存数据的大小
                default: break
                }
            default: break
            }
            return cell
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            _ = tableView.cellForRow(at: indexPath) as! SettingFirstCell
        }else{
            let cell = tableView.cellForRow(at: indexPath) as! SettingCell
            switch indexPath.section {
            case 4:
                switch indexPath.row{
                case 1: cell.clearCacheAlertController()
                default:break
                }
            default:break
            }
        }
        
    }
}
extension SettingTableViewController{
    fileprivate func setNaviItem(){
         navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navBackBtn"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(self.leftItemBackClick))
         self.title = "设置"
//        navigationItem.titleView = navigationBar
//        navigationBar.settingBtn.isHidden = true
//        navigationBar.titleLabel.text = "设置"
//        navigationBar.didSelectBackButton = {[weak self] in
//            self?.navigationController?.popViewController(animated: true)
//        }
    }
}
extension SettingTableViewController{
    @objc private func leftItemBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
