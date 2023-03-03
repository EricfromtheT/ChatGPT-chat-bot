//
//  UserMessage.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import Foundation

struct UserMessage: Encodable {
    let model = "gpt-3.5-turbo"
    let messages: [Message]
}

struct Message: Encodable {
    let role = "user"
    let content: String
}
