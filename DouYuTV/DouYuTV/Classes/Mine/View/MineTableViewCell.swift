//
//  MineTableViewCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/24.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell,RegisterCellFromNib {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    /// 副标题
    @IBOutlet weak var rightLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
