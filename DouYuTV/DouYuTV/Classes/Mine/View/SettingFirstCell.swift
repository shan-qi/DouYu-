//
//  SettingFirstCell.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/25.
//  Copyright © 2018年 单琦. All rights reserved.
//

import UIKit

class SettingFirstCell: UITableViewCell,RegisterCellFromNib {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
