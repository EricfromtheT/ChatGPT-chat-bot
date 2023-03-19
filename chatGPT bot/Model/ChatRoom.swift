//
//  ChatRoom.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/4.
//

import UIKit

protocol ChatCell: UITableViewCell {
    func configure(data: ContentInfo)
}

enum CellType: Int, CaseIterable {
    case fromUser
    case fromBot
    case loading
    
    var cellIdentifier: String {
        switch self {
        case .fromUser:
            return UserMessageCell.identifier
        case .fromBot:
            return BotMessageCell.identifier
        case .loading:
            return LoadingCell.identifier
        }
    }
}

struct ContentInfo: Hashable {
    let identifier: String = UUID().uuidString
    let type: CellType
    let data: String
}
