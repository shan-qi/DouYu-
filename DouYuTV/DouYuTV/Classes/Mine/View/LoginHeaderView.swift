//
//  LoginHeaderView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit


@objc protocol LoginHeaderViewDelegate {
    @objc optional func xq_loginBtnAction(sender:UIButton)
}

class LoginHeaderView: UIView,NibLoadable {
    weak var deleagte : LoginHeaderViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    @IBAction func LoginButton(_ sender: DButton) {
        deleagte?.xq_loginBtnAction!(sender: sender)
    }
    
    @IBAction func RegisterBtn(_ sender: DButton) {
         deleagte?.xq_loginBtnAction!(sender: sender)
    }

}
