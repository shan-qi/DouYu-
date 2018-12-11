//
//  WelcomeViewController.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/6.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
import AVKit
class WelcomeViewController: UIViewController {
    
    
    var playerViewController : AVPlayerViewController?
    var player : AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let path = Bundle.main.path(forResource: "movie.mp4", ofType: nil)
            let videoURL = URL(fileURLWithPath: path!)
            let player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
        }
        do {
            let btn = UIButton(frame: CGRect(x: 0.0, y: xqScreenH - 60, width: 80, height: 44))
            btn.center.x = view.center.x
            btn.setTitle("点击进入", for: .normal)
            btn.addTarget(self, action: #selector(self.loginIn), for: .touchUpInside)
            btn.backgroundColor = UIColor.blue
            btn.layer.cornerRadius = 20
            btn.layer.masksToBounds = true
            view.addSubview(btn)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if player?.status == AVPlayerStatus.readyToPlay {
            player?.play()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player)
        player?.pause()
        player=nil
    }
    
    //视频播放完毕的通知响应
    
    @objc func playerDidFinishPlaying() {
        player?.play()
    }
    @objc func loginIn() {
        let rootVc = MainViewController()
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = rootVc
        }
    }

}
