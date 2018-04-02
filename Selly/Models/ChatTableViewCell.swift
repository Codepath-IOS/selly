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

    @IBOutlet weak var sellerEmailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
