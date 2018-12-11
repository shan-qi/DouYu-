//
//  CollectionDynamicCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/4/19.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionDynamicCell: UICollectionViewCell {
    
    /// 记录话题的范围【正则筛选】
    private lazy var topicRanges = [NSRange]()
    
    private lazy var textStorage = NSTextStorage()
    
    
    @IBOutlet weak var faceImageView: UIImageView!
   
    @IBOutlet weak var sexImageView: UIImageView!
    @IBOutlet weak var levelBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    /// 中间的 view
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleViewHeight: NSLayoutConstraint!
    //热评赞
    @IBOutlet weak var hotCommentLabel: UILabel!
    //热评评论
    @IBOutlet weak var hotComments: UILabel!
    
    
    @IBOutlet weak var hotCommentView: UIView!
    @IBOutlet weak var homeCommentViewHeight: NSLayoutConstraint!
    
    
    //pragma mark: -转发
    @IBOutlet weak var repeatBtn: UIButton!
    //pragma mark: -喜欢
    @IBOutlet weak var likesBtn: UIButton!
    //pragma mark: -评论
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var coverButton: UIButton!
    
    /// 懒加载 collectionView---图片
    private lazy var imageCollectionView = DynamicImageCollectionView.loadViewFromNib()
    /// 懒加载 collectionView---视频
    private lazy var videoCollectionView = DynamicVideoCollectionView.loadViewFromNib()
    
    var didSelectCell: ((_ selectedIndex: Int)->())?
    
    

    var anchorDynamic : DynamicModel?{
        didSet{
            
        let prizeSpace = "  "
            
        titleHeightConstraint.constant = 0
        contentHeightConstraint.constant = 0
        homeCommentViewHeight.constant = 0
        self.hotCommentView.isHidden = true
        
        guard  let iconURL = URL(string: anchorDynamic?.avatar ?? "") else{return}
        let myChe = ImageCache(name: "my_che")
        faceImageView.kf.setImage(with: iconURL,options:[.targetCache(myChe)])
        nickLabel.text = anchorDynamic?.nick_name ?? ""
            if anchorDynamic?.sex == 1{
                sexImageView.image = UIImage(named: "my_video_man")
            }else{
                sexImageView.image = UIImage(named: "my_video_woman")
            }
        levelBtn.setTitle("\(anchorDynamic?.dy_level ?? 0)", for: .normal)
        dateLabel.text = anchorDynamic?.created_at ?? ""
            
        var viewsStr : String = ""
        guard let brocast_Num = anchorDynamic?.views else{return}
        if brocast_Num >= 10000 {
            let brocast = Double(brocast_Num) / 10000.0
            let brocast_num = String(format:"%.1f",brocast)
            viewsStr = "\(brocast_num)万阅读"
        }else{
            viewsStr = "\(brocast_Num)阅读"
        }
        viewsLabel.text = viewsStr
            
        let title = anchorDynamic?.post?["title"] as? String ?? ""
            
        if title == "" {
            self.contentLabel.textColor = UIColor.black
        }else{
            self.contentLabel.textColor = UIColor.lightGray
        }
            
        var content = anchorDynamic!.content
        let prize = anchorDynamic?.prize?.count ?? 0
            
        titleLabel.text = title
            
            if (content.contains("[/user]")) {
                content = content.replacingOccurrences(of: "[/user]", with:"")
            }else if (content.contains("[/topic]")){
                content = content.replacingOccurrences(of: "[/topic]", with:"")
            }
            
        
            
            
        
        
        
            
            
            
        //pragma mark: -富文本前面添加图片
        //热评的内容
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string:content)
            
        //添加属性
        textStorage.setAttributedString(attributeString)
            
        
        let attach : NSTextAttachment = NSTextAttachment()
        attach.image = UIImage(named: "prize")
        attach.bounds = CGRect(x: 0, y: -1, width: 13, height: 13)
        let string : NSAttributedString = NSAttributedString(attachment: attach)
        //正则匹配#斗鱼视频#
        // 匹配话题(加上颜色)
          
            
            
            
            
        
        topicRanges = ranges(from: "#.*?#")
            
        _ = topicRanges.map {
            
            let content  = [NSAttributedStringKey.foregroundColor:UIColor.blueFontColor()]
            attributeString.addAttributes(content, range: $0)
        }
        topicRanges = ranges(from: "@.*?\\s+")
        _ = topicRanges.map {
            let content  = [NSAttributedStringKey.foregroundColor:UIColor.blueFontColor()]
            attributeString.addAttributes(content, range: NSRange(location: $0.location, length: $0.length-1))
        }
          
          
            
//            topicRanges = ranges(from: "\\[[a-z]+\\ssrc=\"[0-9]+\"\\]")
//            _ = topicRanges.map {
//
//                let startIndex = content.startIndex
//
//                let middleIndex = content.index(startIndex, offsetBy: $0.location)
//
//                let endIndex = content.index(startIndex, offsetBy: $0.location + $0.length)
//
//                let contentRange = content[middleIndex..<(endIndex)]
//                print(contentRange)
//
//            }
            
            
            
            
            

            
            if (prize == 0 ) {
                 titleHeightConstraint.constant = (anchorDynamic?.titleLabelH)!
                contentLabel.attributedText = attributeString
            }else{
                contentLabel.text = prizeSpace + content
               titleHeightConstraint.constant = 0
               attributeString.insert(string, at: 0)
               contentLabel.attributedText = attributeString
            }
            if (content.isEmpty){
            contentHeightConstraint.constant = 0
        }else{
            contentHeightConstraint.constant = (anchorDynamic?.contentLabelH)!
        }
            
        //热评部分
        if (anchorDynamic?.sub_comments?.isEmpty)! {
            self.hotCommentView.isHidden = true
            homeCommentViewHeight.constant = 0
        }else{
            self.hotCommentView.isHidden = false
            self.hotCommentView.backgroundColor = UIColor.init(hex: "#FAFAFA")
            for hotComment in (anchorDynamic?.sub_comments)!{
                
                //热评赞
                
                self.hotCommentLabel.text = hotComment["likes"] as? String
                let nick_name = hotComment["nick_name"] as! String
                
                self.hotComments.text = nick_name + ":  " + (hotComment["content"] as! String)
                
                //对热评的部分颜色添加颜色
                let ranStr = nick_name + ":  "
                
                //所有文字变为富文本
                let attrstring:NSMutableAttributedString = NSMutableAttributedString(string:self.hotComments.text!)
                //颜色处理的范围
                
                let str = NSString(string: self.hotComments.text!)
                
                let theRange = str.range(of: ranStr)
                //颜色处理
                attrstring.addAttribute(NSAttributedStringKey.foregroundColor, value:UIColor(r: 72, g: 100, b: 149) , range: theRange)
                self.hotComments.attributedText = attrstring
            }
            self.homeCommentViewHeight.constant = (anchorDynamic?.sub_commentsH)!
        }

        //中间内容
        middleViewHeight.constant = 0
        layoutIfNeeded()
        if #available(iOS 11.0, *) {
            if middleView.contains(imageCollectionView) { imageCollectionView.removeFromSuperview() }
            if middleView.contains(videoCollectionView) { videoCollectionView.removeFromSuperview() }
        } else {
            //  Fallback on earlier versions
        }
        //图片
        if anchorDynamic?.imageArray.count != 0 {
            middleViewHeight.constant = (anchorDynamic?.collectionViewH)!
            middleView.addSubview(imageCollectionView)
            imageCollectionView.frame = CGRect(x: 15, y: 0, width: xqScreenW-30, height: (anchorDynamic?.collectionViewH)!)
            
            imageCollectionView.ThumbImage = (anchorDynamic?.imageArray)!
            imageCollectionView.imglist = anchorDynamic?.imglist
            imageCollectionView.isDynamicImage = true
            imageCollectionView.largeImages = anchorDynamic?.largeImageArray
            imageCollectionView.didSelect = {[weak self] (selectedIndex) in
                self!.didSelectCell?(selectedIndex)
            }
        }
        
        //视频
        if anchorDynamic?.videoArray.count != 0{
            middleViewHeight.constant = (anchorDynamic?.videoCollectionViewH)!
            middleView.addSubview(videoCollectionView)
            videoCollectionView.frame = CGRect(x: 15, y: 0, width: xqScreenW-30, height: (anchorDynamic?.videoCollectionViewH)!)
            videoCollectionView.ThumbVideo = anchorDynamic?.videoArray
        }

        if (anchorDynamic?.dy_level)! >= Int(120) {
            levelBtn.setImage(UIImage(named:"Image_level_120"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#FFFF00")
        }else if (anchorDynamic?.dy_level)! >= Int(110) {
            levelBtn.setImage(UIImage(named:"Image_level_110"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#FF8C00")
        }else if (anchorDynamic?.dy_level)! >= Int(100){
            levelBtn.setImage(UIImage(named:"Image_level_100"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#FFA500")
        }else if (anchorDynamic?.dy_level)! >= Int(90){
            levelBtn.setImage(UIImage(named:"Image_level_90"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#FFD700")
        }else if (anchorDynamic?.dy_level)! >= Int(80){
            levelBtn.setImage(UIImage(named:"Image_level_80"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#FF69B4")
        }else if (anchorDynamic?.dy_level)! >= Int(70){
            levelBtn.setImage(UIImage(named:"Image_level_70"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#DA70D6")
        }else if (anchorDynamic?.dy_level)! >= Int(60){
            levelBtn.setImage(UIImage(named:"Image_level_60"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#8A2BE2")
        }else if (anchorDynamic?.dy_level)! >= Int(50){
            levelBtn.setImage(UIImage(named:"Image_level_50"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#9370DB")
        }else if (anchorDynamic?.dy_level)! >= Int(40){
            levelBtn.setImage(UIImage(named:"Image_level_40"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#4169E1")
        }else if (anchorDynamic?.dy_level)! >= Int(30){
            levelBtn.setImage(UIImage(named:"Image_level_30"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#87CEFA")
        }else if (anchorDynamic?.dy_level)! >= Int(15){
            levelBtn.setImage(UIImage(named:"Image_level_15"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#90EE90")
        }else {
            levelBtn.setImage(UIImage(named:"Image_level_01"), for: .normal)
            levelBtn.backgroundColor = UIColor.init(hex: "#F5DEB3")
        }
        if anchorDynamic?.likes == 0 {
            likesBtn.setTitle("赞", for: .normal)
        }else{
            likesBtn.setTitle("\(anchorDynamic?.likes ?? 0)", for: .normal)
        }
        if anchorDynamic?.total_comments == 0 {
            commentBtn.setTitle("评论", for: .normal)
        }else{
          commentBtn.setTitle("\(anchorDynamic?.total_comments ?? 0)", for: .normal)
        }
        if anchorDynamic?.reposts == 0 {
            repeatBtn.setTitle("转发", for: .normal)
        }else{
            repeatBtn.setTitle("\(anchorDynamic?.reposts ?? 0)", for: .normal)
        }
      }
    }
    func rangesOfLink() -> [NSRange] {
        // 检测正则表达式，NSDataDetector 是 NSRegularExpression 的子类
        let regex = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        return results(from: regex)
    }
    
    /// 返回正则表达式匹配的结果范围
    func ranges(from pattern: String) -> [NSRange] {
        // 创建正则表达式对象
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        return results(from: regex)
    }
    
    /// 返回正则表达式的结果
    private func results(from regex: NSRegularExpression) -> [NSRange] {
        // 开始匹配，返回结果
        let checkingResults = regex.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))
        return checkingResults.map({ $0.range })
    }
   
}


