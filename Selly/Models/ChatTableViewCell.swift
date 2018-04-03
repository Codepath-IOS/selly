//
//  ChatTableViewCell.swift
//  Selly
//
//  Created by siddhant on 3/31/18.
//  Copyright © 2018 siddhant. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sellerImage: UIImageView!
   
    @IBOutlet weak var sellerNameLabel: UILabel!

    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sellerImage.layer.borderWidth = 1
        sellerImage.layer.masksToBounds = false
        sellerImage.layer.borderColor = UIColor.black.cgColor
        sellerImage.layer.cornerRadius = sellerImage.frame.height/2
        sellerImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
