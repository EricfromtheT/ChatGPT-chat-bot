//
//  BotResponse.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import Foundation

struct BotResponse: Decodable {
    let created: Int
    let choices: [Choice]
}

struct Choice: Decodable {
    let index: Int
    let message: BotMessage
    let finishReason: String
    
    enum CodingKeys: String, CodingKey {
        case finishReason = "finish_reason"
        case index, message
    }
}

struct BotMessage: Decodable {
    let role: String
    let content: String
}
