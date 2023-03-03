//
//  ChatManager.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import Foundation

final class ChatManager {
    static let shared = ChatManager()
    private let urlString = "https://api.openai.com/v1/chat/completions"
    private let urlSession: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + APIInfo.shared.key
        ]
        urlSession = URLSession(configuration: configuration)
    }
    
    func postMessage(message: String) async throws -> String? {
        let request = try packDataInRequest(message: message)
        let (data, _) = try await urlSession.data(for: request)
        let reply = try JSONDecoder().decode(BotResponse.self, from: data)
        let replyMessage = reply.choices.first?.message.content
        return replyMessage
    }
    
    private func packDataInRequest(message: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let message = Message(content: message)
        let body = try JSONEncoder().encode(UserMessage(messages: [message]))
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.httpBody = body
        return request
    }
}
