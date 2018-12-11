//
//  XQBaseTableViewCell.swift
//  DouYuTV
//
//  Created by 小琦 on 2018/11/12.
//  Copyright © 2018 单琦. All rights reserved.
//

import UIKit

class XQBaseTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .none
        self.contentView.backgroundColor = kWhite
        
        xq_initWithView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func xq_initWithView(){}
    
    public class func cellHeight() -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    public class func cellHeightWithModel(model : Any) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public class func identifier() -> String {
        
        let name: AnyClass! = object_getClass(self)
        return NSStringFromClass(name)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
