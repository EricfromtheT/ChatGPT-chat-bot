//
//  ChatViewModel.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import Foundation
import Combine

final class ChatViewModel {
    
    @Published var prompt: String = ""
    var promptIsEmpty: AnyPublisher<Bool, Never> {
        $prompt.map { $0.isEmpty }.eraseToAnyPublisher()
    }
    var reply = PassthroughSubject<String, Never>()
    private var isAllowedToSend = true
    
    func getBotResponse() {
        if isAllowedToSend {
            isAllowedToSend = false
            Task {
                do {
                    guard let reply = try await ChatManager.shared.postMessage(message: prompt)
                    else { return }
                    self.reply.send(reply.trimmingCharacters(in: .whitespacesAndNewlines))
                    isAllowedToSend = true
                } catch {
                    print("Function: \(#function) has error of \(error.localizedDescription)")
                    self.reply.send("⚠️internet problem: please send your message again or check your connection")
                    isAllowedToSend = true
                }
            }
        }
    }
}
