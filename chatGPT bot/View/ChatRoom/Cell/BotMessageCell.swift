//
//  BotMessageCell.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit

class BotMessageCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
