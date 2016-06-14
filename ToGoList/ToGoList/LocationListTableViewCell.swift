//
//  LocationListTableViewCell.swift
//  ToGoList
//
//  Created by 林紹瑾 on 2016/6/14.
//  Copyright © 2016年 group7. All rights reserved.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationTypeImage: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationPhoneNumberLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
