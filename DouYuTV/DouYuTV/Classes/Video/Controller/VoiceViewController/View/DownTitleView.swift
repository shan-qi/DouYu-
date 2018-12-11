//
//  DownAndUpView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/12.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

//定义协议
protocol downTitleViewDelegate : class {
    func  downTitleView(_ titleView : DownTitleView , selectedIndex index : Int)
}
//定义常量
private let xqfirstLabelW = xqScreenW / xqLabelItem
private let xqLabelWidth = xqScreenW / 4
class DownTitleView: UIView {
    //1.属性定义
    var flag : Bool = false
    private var titles : [String] = []
    private var currentIndex : Int = 0
    weak var delegate : downTitleViewDelegate?
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var BK : UIView = {
        let bk = UIView(frame: CGRect(x: 0, y: 0, width: xqScreenW, height: 50))
        bk.backgroundColor = UIColor.white
        return bk
    }()
    
    //2.进行懒加载(UIScrollView)
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.isPagingEnabled = false
        scrollView.contentSize = CGSize(width:(xqScreenW  * CGFloat(titles.count))/2.5 , height: 0)
//        scrollView.scrollRectToVisible( CGRect(x:CGFloat(currentIndex) * xqScreenW , y: 0, width: xqScreenW, height: 40), animated: true)
        return scrollView
    }()
    private lazy var downView : UIView = {
        let downView = UIView()
        downView.frame = CGRect(x: xqScreenW - 50, y: 0, width: 50, height: 50)
        downView.backgroundColor = UIColor.white
        return downView
    }()
    private lazy var downAndUpImageView : UIImageView = {
        let downAndUpImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        downAndUpImageView.image = UIImage(named: "sublive_threeclassify_expand")
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        downAndUpImageView.addGestureRecognizer(singleTapGesture)
        downAndUpImageView.isUserInteractionEnabled = true
        return downAndUpImageView
    }()
    //1>添加titleView中的label
    private func setTitleLabel(){
        let labelH : CGFloat = 30
        let labelY : CGFloat = 10
        for (index , title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.layer.cornerRadius = 15
            label.layer.masksToBounds = true
            //3.设置label的尺寸
            let  labelW = getLabelWidth(str:"     \(title)     " , font: UIFont.systemFont(ofSize: 13.0), height: 30)
            var labelX : CGFloat = labelW * CGFloat(index) + 10
            if index != 0{
                labelX  = 100 * CGFloat(index) - 15
                label.oldLabel(label)
                
            }else{
                label.currentLabel(label)
            }
            label.frame = CGRect(x: labelX , y: labelY, width: labelW, height: labelH)
            //4.将label放入scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelTitleClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    //pragma mark: -添加底部对应的BottomLine
    private lazy var bottomLineView : UIView = {
        let bottomLineView = UIView(frame: CGRect(x: 0, y: 49, width: frame.width, height: 1))
        bottomLineView.backgroundColor = UIColor.lightGray
        return bottomLineView
    }()
    //pragma mark: -自定义构造函数
    init(frame : CGRect ,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DownTitleView{
    private func setUI(){
        //1.将scrollView放入PageTitleView中
        addSubview(BK)
        BK.addSubview(scrollView)
        BK.addSubview(downView)
        BK.addSubview(bottomLineView)
        downView.addSubview(downAndUpImageView)
        scrollView.frame = bounds
        //2.添加title对应的label
        setTitleLabel()
    }
    
    func getLabelWidth(str: String, font: UIFont, height: CGFloat)-> CGFloat {
        let statusLabelText: NSString = str as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
        
        return strSize.width
    }
}
extension DownTitleView{
    @objc private func labelTitleClick(tapGes:UITapGestureRecognizer){
        //0.获取当前label
        guard let currentLabel = (tapGes.view) as? UILabel else{return}
        //1.判断再次点击直接返回
        if currentLabel.tag  == currentIndex {return}
        //2.获取之前label
        let oldLabel = titleLabels[currentIndex]
        //3.获取文字颜色
        currentLabel.currentLabel(currentLabel)
        oldLabel.oldLabel(oldLabel)
        //4.保持最新currentLabel的下标值
        currentIndex = currentLabel.tag
        //6.通知代理
        delegate?.downTitleView(self, selectedIndex: currentIndex)
        self.changeScrollOffSet(index: currentIndex)
    }
}
extension DownTitleView{
    func changeScrollOffSet(index : NSInteger){
        let  halfWidth : CGFloat = xqScreenW / 2.5
        let  scrollWidth : CGFloat = xqScreenW / 4 * CGFloat(titles.count)
        //3.637
        var leftSpace : CGFloat = xqLabelWidth * CGFloat(index) - halfWidth + xqLabelWidth / 2.0
        if(leftSpace<0){
            leftSpace = 0
        }
        if leftSpace > scrollWidth - (2 * halfWidth){
            leftSpace = scrollWidth - (2 * halfWidth)
        }
        scrollView.setContentOffset(CGPoint(x: leftSpace  , y: 0), animated: true)
    }
}
extension DownTitleView{
    @objc func imageViewClick(){
        if !flag {
            flag = true
            self.BK.frame.size.height = 150
            self.bottomLineView.frame.origin.y = self.BK.frame.size.height - 50
            self.bottomLineView.frame.size.height = 1
            self.downView.frame.origin.y = 100
            self.downAndUpImageView.image = UIImage(named: "sublive_threeclassify_fold")
        }else{
            flag = false
            self.BK.frame.size.height = 50
            self.bottomLineView.frame.origin.y = self.BK.frame.size.height
            self.bottomLineView.frame.size.height = 1
            self.downView.frame.origin.y = 0
            self.downAndUpImageView.image = UIImage(named: "sublive_threeclassify_expand")
            scrollView.contentSize = CGSize(width:(xqScreenW  * CGFloat(titles.count))/2.5 , height: 0)
        }
    }
}


