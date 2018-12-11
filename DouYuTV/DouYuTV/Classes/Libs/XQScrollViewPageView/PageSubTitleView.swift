//
//  PageSubTitleView.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/30.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
//定义协议
protocol pageSubTitleViewDelegate : class {
    func  pageSubTitleView(_ titleView : PageSubTitleView , selectedIndex index : Int)
}
class PageSubTitleView: UIView {
    //pragma mark: -对外的属性
    weak var delegate : pageSubTitleViewDelegate?
    //1.属性定义
    fileprivate var titles : [String]!
    
    fileprivate var currentIndex : Int = 0
   
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    private  var styles : XQTitleStyle!
    //2.进行懒加载(UIScrollView)
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
        scrollView.isPagingEnabled = false
        scrollView.contentSize = CGSize(width:xqScreenW, height: 0)
        return scrollView
    }()
    //3.进行懒加载(ScrollLine)
     lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.layer.borderWidth = 1
        bottomLine.layer.cornerRadius = 2
        bottomLine.layer.borderColor = UIColor.orange.cgColor
        bottomLine.layer.masksToBounds = true
        bottomLine.backgroundColor = styles.bottomLineColor
        return bottomLine
    }()
    // 底部分割线
     lazy var splitLineView : UIView = {
        let splitView = UIView()
        splitView.backgroundColor = UIColor.init(hex: "#EEE9E9")
        let h : CGFloat = 0.5
        splitView.frame = CGRect(x: 0, y: self.frame.height - h, width: self.frame.width, height: h)
        return splitView
    }()
    // title的背景颜色
    fileprivate lazy var coverView : UIView = {
        let coverView = UIView()
        coverView.backgroundColor = styles.coverBgColor
        coverView.alpha = 0.7
        return coverView
    }()
    
    // MARK: 计算属性
    fileprivate lazy var normalColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(styles.normalColor)
    
    fileprivate lazy var selectedColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(styles.selectedColor)
    //pragma mark: -自定义构造函数
    init(frame : CGRect ,titles:[String],style : XQTitleStyle) {
        self.titles = titles
        styles = style
        super.init(frame: frame)
        //设置UI界面
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PageSubTitleView{
    private func setUI(){
        // 0.设置自己的背景
        if styles.titleGradColors != nil {
            //设置背景渐变
            let gradientLayer : CAGradientLayer = CAGradientLayer()
            gradientLayer.colors = styles.titleGradColors
            //(这里的起始和终止位置就是按照坐标系,四个角分别是左上(0,0),左下(0,1),右上(1,0),右下(1,1))
            //渲染的起始位置
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
            //渲染的终止位置
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
            //设置frame和插入view的layer
            gradientLayer.frame = bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
        }else{
            scrollView.backgroundColor = styles.titleBgColor
        }
    
        //1.将scrollView放入PageTitleView中
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2.添加底部分割线
        addSubview(splitLineView)
        
        // 3.设置所有的标题Label
        setupTitleLabels()
        
        // 4.设置Label的frame
        setupTitleLabelsFrame()
        // 5.设置底部的滚动条(添加到 scrollView 里面因为要滚动)
        if styles.isShowBottomLine {
            setupBottomLine()
        }
        
        // 6.设置遮盖的View(添加到 scrollView 里面因为要滚动)
        if styles.isShowCover {
            setupCoverView()
        }
    }
    //1>添加titleView中的label
    private func setupTitleLabels(){
        for (index , title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.textColor = index == 0 ? styles.selectedColor : styles.normalColor
            label.font = styles.font
            label.textAlignment = .center
            //3.将label放入scrollView
            scrollView.addSubview(label)
            titleLabels.append(label)
            //4.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelTitleClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func setupTitleLabelsFrame() {
        
        var titleX: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        let titleH : CGFloat = frame.height
        
        let count = titles.count
        
        for (index, label) in titleLabels.enumerated() {
            
            if styles.isScrollEnable { // 可以滚动
                let rect = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : styles.font], context: nil)
                titleW = rect.width
                if index == 0 { // 当为第一个的时候, x 距离左边的距离为间距的一班
                    titleX = styles.titleMargin * 0.5
                } else {
                    // 拿到上一个 label
                    let preLabel = titleLabels[index - 1]
                    titleX = preLabel.frame.maxX + styles.titleMargin
                }
                
            } else { // 不能滚动
                titleW = frame.width / CGFloat(count)
                titleX = titleW * CGFloat(index)
            }
            
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            
            // 放大的代码
            if index == 1 {
                let scale = styles.isNeedScale ? styles.scaleRange : 1.0
                label.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        // 设置 scrollView 的 contentSize
        if styles.isScrollEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + styles.titleMargin * 0.5, height: 0)
        }
    }
    fileprivate func setupBottomLine() {
        scrollView.addSubview(bottomLine)
        let firstLabel : UILabel = titleLabels[0]
        bottomLine.frame = CGRect(x: firstLabel.frame.origin.x +  firstLabel.frame.width / 3 , y:bounds.height - styles.bottomLineH, width: firstLabel.frame.width / 3, height: styles.bottomLineH)
    }
    
    fileprivate func setupCoverView() {
        scrollView.insertSubview(coverView, at: 0)
        let firstLabel = titleLabels[0]
        var coverW = firstLabel.frame.width
        let coverH = styles.coverH
        var coverX = firstLabel.frame.origin.x
        let coverY = (bounds.height - coverH) * 0.5
        
        if styles.isScrollEnable {
            coverX -= styles.coverMargin
            coverW += styles.coverMargin * 2
        }
        coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        
        coverView.layer.cornerRadius = styles.coverRadius
        coverView.layer.masksToBounds = true
    }
}
extension PageSubTitleView{
    @objc private func labelTitleClick(tapGes:UITapGestureRecognizer){       
        // 0.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        // 3.切换文字的颜色
        currentLabel.textColor = styles.selectedColor
        oldLabel.textColor = styles.normalColor
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.通知contentView 进行调整位置(利用代理)
        delegate?.pageSubTitleView(self, selectedIndex: currentIndex)
        
        // 6.居中显示
        contentViewDidEndScroll()
        
        // 7.调整bottomLine
        if styles.isShowBottomLine {
            UIView.animate(withDuration: 0.15, animations: {
                self.bottomLine.frame.origin.x = currentLabel.frame.origin.x + (self.titleLabels.first?.frame.width)! / 3
                self.bottomLine.frame.size.width = currentLabel.frame.size.width / 3
            })
        }
        
        // 8.调整比例
        if styles.isNeedScale {
            oldLabel.transform = CGAffineTransform.identity
            currentLabel.transform = CGAffineTransform(scaleX: styles.scaleRange, y: styles.scaleRange)
        }
        
        // 9.遮盖移动
        if styles.isShowCover {
            let coverX = styles.isScrollEnable ? (currentLabel.frame.origin.x - styles.coverMargin) : currentLabel.frame.origin.x
            let coverW = styles.isScrollEnable ? (currentLabel.frame.width + styles.coverMargin * 2) : currentLabel.frame.width
            UIView.animate(withDuration: 0.15, animations: {
                self.coverView.frame.origin.x = coverX
                self.coverView.frame.size.width = coverW
            })
        }
    }
}
// MARK:- 获取RGB的值
extension PageSubTitleView {
    fileprivate func getRGBWithColor(_ color : UIColor) -> (CGFloat, CGFloat, CGFloat) {
        guard let components = color.cgColor.components else {
            fatalError("请使用RGB方式给Title赋值颜色")
        }        
        return (components[0] * 255, components[1] * 255, components[2] * 255)
    }
}
//对外暴露
extension PageSubTitleView{
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (selectedColorRGB.0 - normalColorRGB.0, selectedColorRGB.1 - normalColorRGB.1, selectedColorRGB.2 - normalColorRGB.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: selectedColorRGB.0 - colorDelta.0 * progress, g: selectedColorRGB.1 - colorDelta.1 * progress, b: selectedColorRGB.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: normalColorRGB.0 + colorDelta.0 * progress, g: normalColorRGB.1 + colorDelta.1 * progress, b: normalColorRGB.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveTotalW = targetLabel.frame.width - sourceLabel.frame.width
        
        // 5.放大的比例
        if styles.isNeedScale {
            let scaleDelta = (styles.scaleRange - 1.0) * progress
            sourceLabel.transform = CGAffineTransform(scaleX: styles.scaleRange - scaleDelta, y: styles.scaleRange - scaleDelta)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + scaleDelta, y: 1.0 + scaleDelta)
        }
        
        // 6.计算cover的滚动
        if styles.isShowCover {
            coverView.frame.size.width = styles.isScrollEnable ? (sourceLabel.frame.width + 2 * styles.coverMargin + moveTotalW * progress) : (sourceLabel.frame.width + moveTotalW * progress)
            coverView.frame.origin.x = styles.isScrollEnable ? (sourceLabel.frame.origin.x - styles.coverMargin + moveTotalX * progress) : (sourceLabel.frame.origin.x + moveTotalX * progress)
        }
    }
    
    // MARK: 让 title 的位置居中
    func contentViewDidEndScroll() {
        // 0.如果是不需要滚动,则不需要调整中间位置
        guard styles.isScrollEnable else { return }
        
        // 1.获取获取目标的Label
        let targetLabel = titleLabels[currentIndex]
        
        // 2.计算和中间位置的偏移量
        var offSetX = targetLabel.center.x - bounds.width * 0.5
        if offSetX < 0 {
            offSetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offSetX > maxOffset {
            offSetX = maxOffset
        }
        
        // 3.滚动UIScrollView
        scrollView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
 

}
