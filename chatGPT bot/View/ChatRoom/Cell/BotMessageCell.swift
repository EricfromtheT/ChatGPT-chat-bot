//
//  BotMessageCell.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit

class BotMessageCell: UITableViewCell, ChatCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
        backView.layer.cornerRadius = 10
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }

    func configure(data: ContentInfo) {
        messageLabel.text = data.data
    }
    
}
