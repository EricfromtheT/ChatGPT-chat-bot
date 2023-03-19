//
//  ChatTableView.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit

final class ChatTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = UIColor.asset(.ChatBackColor)
        separatorStyle = .none
        register(UINib(nibName: UserMessageCell.identifier, bundle: nil),
                 forCellReuseIdentifier: UserMessageCell.identifier)
        register(UINib(nibName: BotMessageCell.identifier, bundle: nil),
                 forCellReuseIdentifier: BotMessageCell.identifier)
        register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
