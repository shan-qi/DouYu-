//
//  XQPublishViewController.swift
//  xqapp
//
//  Created by 单琦 on 2018/5/16.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit


class XQPublishViewController: UIViewController {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var yearAndMonthLabel: UILabel!
    var buttons : [XQVerticalButton] = [XQVerticalButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDate()
        let images = ["btn_live_home",
                      "btn_gamelive_home",
                      "btn_audio_live_home",
                      "btn_video_home",
                      "btn_note_home",
                      "btn_yuyin_home"]
        let titles = ["摄像直播",
                      "手游直播",
                      "语音直播",
                      "拍个视频",
                      "发布动态",
                      "语音开黑"]
        
        let maxCols: CGFloat = 4
        
        let buttonW: CGFloat = 72
        
        let buttonH = buttonW + 30
        
        let buttonMargn: CGFloat = 15
        let buttonSpace: CGFloat = (xqScreenW - buttonW * maxCols - buttonMargn * 2) / (maxCols - 1)
        
        let startY: CGFloat = xqScreenH / 1.5 - buttonW
        for i in 0...5 {
            let button = XQVerticalButton()
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setImage(UIImage(named: images[i]), for: .normal)
            
            let row = i / Int(maxCols)
            let col = CGFloat(i).truncatingRemainder(dividingBy: maxCols)
            
            button.frame = CGRect(x: buttonMargn + col * (buttonSpace + buttonW), y: startY + CGFloat(row) * (buttonH + buttonMargn), width: buttonW, height: buttonH)
            view.addSubview(button)
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            button.isHidden = true
            buttons.append(button)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i + 1) * 0.1, execute: {
                
                button.isHidden = false
                
                let spring = CASpringAnimation(keyPath: "position.y")
                // 阻尼系数， 越大，体制越快
                spring.damping = 10
                // 刚度系数，刚度系数越大，形变产生的力就越大，运动越快
                spring.stiffness = 100
                // 质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
                spring.mass = 1
                // 初始速度，动画试图的初始速度大小，速度为正数时，速度方向与运动方向一致，负数时，速度方向与运动方向相反
                spring.initialVelocity = 0
                spring.fromValue = row * (-30)
                spring.toValue = button.layer.position.y
                // 结算时间
                spring.duration = spring.settlingDuration
                button.layer.add(spring, forKey: spring.keyPath)
            })
            
        }
        
    }
    @IBAction func disMissButton(_ sender: UIButton) {
        for i in 1...buttons.count {
            let button = buttons[i - 1]
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i) * 0.1, execute: {
                let spring = CASpringAnimation(keyPath: "position.y")
                spring.damping = 10
                spring.stiffness = 100
                spring.mass = 1
                spring.initialVelocity = 0
                spring.fromValue = button.layer.position.y
                spring.toValue = xqScreenH + 100
                spring.duration = 1
                button.layer.add(spring, forKey: spring.keyPath)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + spring.duration, execute: {
                    button.isHidden = true
                })
                if i == self.buttons.count {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                        self.dismiss(animated: false, completion: nil)
                    })
                }
            })
        }
        
        
    }
    @objc private func buttonClick(_ button: UIButton) {
        for i in 1...buttons.count {
            let button = buttons[i - 1]
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(i) * 0.1, execute: {
                let spring = CASpringAnimation(keyPath: "position.y")
                spring.damping = 10
                spring.stiffness = 100
                spring.mass = 1
                spring.initialVelocity = 0
                spring.fromValue = button.layer.position.y
                spring.toValue = xqScreenH + 100
                spring.duration = 1
                button.layer.add(spring, forKey: spring.keyPath)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + spring.duration, execute: {
                    button.isHidden = true
                })
                if i == self.buttons.count {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                        self.dismiss(animated: false, completion: {
                            //                            // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
                            //                            let root = UIApplication.shared.keyWindow?.rootViewController
                            //                            let vc = XQPublishNavgationViewController()
                            //                            root?.present(vc, animated: true, completion: nil)
                            
                        })
                    })
                }
            })
        }
    }
    
}
extension XQPublishViewController{
    func setUpDate(){
        dayLabel.text = Date().getDay()
        dayLabel.font = UIFont.boldSystemFont(ofSize: 40)
        weekDayLabel.text = Date().weekDay()
        yearAndMonthLabel.text = "\(Date().getMonth())/\(Date().getYear())"
    }
}

