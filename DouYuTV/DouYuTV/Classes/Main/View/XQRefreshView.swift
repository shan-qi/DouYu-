//
//  XQRefreshView.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/13.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit
import ESPullToRefresh
class XQRefreshView: XQBaseView,ESRefreshProtocol,ESRefreshAnimatorProtocol {
    
   public var view: UIView {return self}
    
   public var insets: UIEdgeInsets = UIEdgeInsets.zero
    
   public var duration: TimeInterval = 0.3

    
   public var trigger: CGFloat = 56.0
    
   public var executeIncremental: CGFloat = 56.0
    
   public var state: ESRefreshViewState = .pullToRefresh
    
    
    private lazy var imageView : UIImageView = {
       let imageView = UIImageView.init()
       imageView.image = UIImage.init(named: "img_mj_statePulling")
       return imageView
    }()
    
    override func xq_initWithView() {
        addSubview(imageView)
    }
    
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        imageView.center = self.center
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.imageView.frame = CGRect.init(x: (self.bounds.size.width - 100.0)/2, y: (self.bounds.size.height - 50.0)/2, width: 100.0, height: 50.0)
        }) { (finished) in
            var images = [UIImage]()
            for index in 0...19{
                let imageName = String(format: "img_mj_stateRefreshing_%03d",index)
                if  let image = UIImage(named: imageName){
                    images.append(image)
                }
            }
            self.imageView.animationDuration = 0.6
            self.imageView.animationImages = images
            self.imageView.animationRepeatCount = 0
            self.imageView.startAnimating()
        }
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        self.imageView.stopAnimating()
        imageView.image = UIImage(named: "img_mj_statePulling")
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.refresh(view: view, progressDidChange: 0.0)
        }) { (finished) in
        }
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = max(0.0, min(1.0,progress))
        self.imageView.frame = CGRect.init(x: (self.bounds.size.width - 100.0) / 2, y: (self.bounds.size.height - 50.0 * p) / 2, width: 100.0, height: 50.0 * p)
        
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard  self.state != state else{
            return
        }
        self.state = state
        
        switch state {
        case .pullToRefresh:
            var images = [UIImage]()
            for index in 0...19{
                let imageName = String(format: "img_mj_stateRefreshing_%03d", index)
                if let image = UIImage(named: imageName){
                    images.append(image)
                }
            }
            self.imageView.animationDuration = 0.6
            self.imageView.animationRepeatCount = 0
            self.imageView.animationImages = images
            self.imageView.image = UIImage.init(named: "img_mj_statePulling")
            self.imageView.startAnimating()
            break
        case .releaseToRefresh :
            var images = [UIImage]()
            for index in 0...19{
                let imageName = String(format: "img_mj_stateRefreshing_%03d", index)
                if let image = UIImage(named: imageName){
                    images.append(image)
                }
            }
            self.imageView.animationDuration = 0.6
            self.imageView.animationRepeatCount = 0
            self.imageView.animationImages = images
            self.imageView.image = UIImage.init(named: "img_mj_statePulling")
            self.imageView.startAnimating()
            break
        default:
            break
        }
    }
    
    
    

    

}
