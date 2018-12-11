//
//  XQPopLoginView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/9.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit


protocol XQPopLoginViewDelegate : class {
    func xq_goToLoginVC()
    func xq_goToRegisterVC()
}
class XQPopLoginView: UIView {
    
    weak var delegate : XQPopLoginViewDelegate?
    
    private lazy var bgView : UIView = UIView()
    private lazy var topImgV : UIImageView = UIImageView()
    private lazy var titleLab : UILabel = UILabel()
    private lazy var loginBtn : UIButton = UIButton()
    private lazy var registerBtn : UIButton = UIButton()
    private lazy var descLab : UILabel = UILabel()
    private lazy var otherLab : UILabel = UILabel()
    private lazy var closeBtn : UIButton = UIButton()
    
    private lazy var iconArr : [String] = {
        let iconArr = ["dy_share_to_weixin_normal","dy_share_to_qq_normal","dy_share_to_sina_normal"]
        return iconArr
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xq_initWithAllView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func xq_initWithAllView(){
        backgroundColor = colorWithRGBA(33, 33, 33, 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(xq_HiddenLoginView))
        self.addGestureRecognizer(tap)
        self.isHidden = true
        setUpAllView()
    }
    // 隐藏弹窗
    @objc func xq_HiddenLoginView() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
            self.bgView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (isSuccess) in
            
            self.isHidden = true
        }
    }
    
    // 显示弹窗
    func xq_showLoginView() {
        self.alpha = 0.0
        self.isHidden = false
        self.bgView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.bgView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (isSuccess) in
            
            
        }
    }
    @objc private func bgTapAction() {
        
    }
    
}

extension XQPopLoginView{
    private func setUpAllView() {
        
        self.bgView = UIView.xq_createView(bgClor: kWhite, supView: self, closure: { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(xqScreenW - Adapt(40))
            make.height.equalTo(xqScreenH - Adapt(280))
        })
        
        let bgTap = UITapGestureRecognizer(target: self, action: #selector(bgTapAction))
        self.bgView.addGestureRecognizer(bgTap)
        
        self.titleLab = UILabel.xq_createLabel(text: "登录", textColor:  kBlack, font: BoldFontSize(30), supView: self.bgView, closure: { (make) in
            make.left.equalTo(Adapt(30))
            make.top.equalTo(Adapt(50))
            make.height.equalTo(Adapt(32))
        })
        
        self.topImgV = UIImageView.xq_createImageView(imageName: "dyunion_logo_6", supView: self.bgView, closure: { (make) in
            make.centerX.equalTo(self.bgView.snp.centerX)
            make.bottom.equalTo(self.titleLab.snp.bottom).offset(Adapt(10))
            make.width.equalTo(Adapt(200))
            make.height.equalTo(Adapt(130))
        })
        
        self.topImgV.contentMode = .scaleAspectFill
        
        self.loginBtn = UIButton.xq_createButton(title: "斗鱼账号登录", titleStatu: .normal, imageName: nil, imageStatu: nil, supView: self.bgView, closure: { (make) in
            make.top.equalTo(self.titleLab.snp.bottom).offset(Adapt(20))
            make.left.equalTo(Adapt(20))
            make.right.equalTo(Adapt(-20))
            make.height.equalTo(Adapt(50))
        })
        
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        loginBtn.setTitleColor(kWhite, for: .normal)
        loginBtn.backgroundColor = kMainOrangeColor
        loginBtn.titleLabel?.font = FontSize(15)
        loginBtn.layer.cornerRadius = 3
        
        
        self.registerBtn = UIButton.xq_createButton(title: "快速注册", titleStatu: .normal, imageName: nil, imageStatu: nil, supView: self.bgView, closure: { (make) in
            make.top.equalTo(self.loginBtn.snp.bottom).offset(Adapt(20))
            make.left.equalTo(Adapt(20))
            make.right.equalTo(Adapt(-20))
            make.height.equalTo(Adapt(50))
        })
        
        registerBtn.setTitleColor(kMainOrangeColor, for: .normal)
        registerBtn.backgroundColor =  kWhite
        registerBtn.titleLabel?.font = FontSize(15)
        registerBtn.layer.cornerRadius = 3
        registerBtn.layer.borderColor = kMainOrangeColor.cgColor
        registerBtn.layer.borderWidth = 0.6
        registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        self.descLab = UILabel.xq_createLabel(text: "使用即为同意使用《斗鱼注册协议及版权声明》", textColor: kGrayTextColor, font: FontSize(12), supView: self.bgView, closure: { (make) in
            make.top.equalTo(self.registerBtn.snp.bottom).offset(20)
            make.left.equalTo(self.registerBtn.snp.left)
        })
        
        self.otherLab = UILabel.xq_createLabel(text: "快速登录", textColor:  kGrayTextColor, font: FontSize(14), supView: self.bgView, closure: { (make) in
            make.centerX.equalTo(bgView.snp.centerX)
            make.top.equalTo(descLab.snp.bottom).offset(Adapt(30))
        })
        
        self.closeBtn = UIButton.xq_createButton(title: "", titleStatu: .normal, imageName: "linkdanmuAlertClose", imageStatu: .normal, supView: self.bgView, closure: { (make) in
            make.top.equalTo(bgView.snp.top).offset(Adapt(5))
            make.right.equalTo(bgView.snp.right).offset(Adapt(-5))
            make.width.height.equalTo(Adapt(20))
        })
        
        self.closeBtn.addTarget(self, action: #selector(xq_HiddenLoginView), for: .touchUpInside)
        //  三方登录 icon
        var i = 0
        let btnWH : CGFloat = Adapt(50)
        let btnMargin : CGFloat = Adapt(20)
        let btnCount : CGFloat = CGFloat(self.iconArr.count)
        let allBtnW = btnWH * btnCount + (btnCount - 1) * btnMargin
        let bgViewW = xqScreenW - Adapt(40)
        for item in self.iconArr {
            
            let iconBtn = UIButton()
            iconBtn.setImage(UIImage(named: item), for: .normal)
            self.bgView.addSubview(iconBtn)
            let btnX : CGFloat = (bgViewW - allBtnW) / 2 + CGFloat(i) * (btnWH + btnMargin)
            
            iconBtn.snp.makeConstraints { (make) in
                make.left.equalTo(self.bgView.snp.left).offset(btnX)
                make.bottom.equalTo(-Adapt(20))
                make.width.equalTo(btnWH)
                make.height.equalTo(btnWH)
            }
            i += 1
        }
    }
    
    @objc func loginBtnClick() {
        self.xq_HiddenLoginView()
        delegate?.xq_goToLoginVC()
    }
    
    @objc func registerBtnClick() {
        
        self.xq_HiddenLoginView()
        delegate?.xq_goToRegisterVC()
    }
}
