//
//  ChatBaseView.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit

class ChatBaseView: UIView {
    let promptTextView = UITextView()
    let senderBackView = UIView()
    let sendButton = UIButton()
    let chatTableView = ChatTableView()
    let senderStack = UIStackView()
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        setConstraints()
        setUpLook()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        addSubview(senderBackView)
        senderBackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(chatTableView)
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        
        senderBackView.addSubview(senderStack)
        senderStack.translatesAutoresizingMaskIntoConstraints = false
        
        senderStack.addArrangedSubview(promptTextView)
        promptTextView.translatesAutoresizingMaskIntoConstraints = false

        senderStack.addArrangedSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            senderBackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            senderBackView.heightAnchor.constraint(equalToConstant: 60),
            senderBackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            senderStack.centerXAnchor.constraint(equalTo: senderBackView.centerXAnchor),
            senderStack.centerYAnchor.constraint(equalTo: senderBackView.centerYAnchor),
            promptTextView.widthAnchor.constraint(equalTo: senderBackView.widthAnchor, multiplier: 0.7),
            
            chatTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: senderBackView.topAnchor),
            chatTableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setUpLook() {
        backgroundColor = .black
        senderStack.spacing = 15
        senderStack.axis = .horizontal
        promptTextView.backgroundColor = .systemBackground
        promptTextView.font = UIFont.systemFont(ofSize: 21)
        senderBackView.backgroundColor = .black
        sendButton.backgroundColor = .label
        sendButton.setTitle("Send", for: .normal)
        sendButton.isEnabled = false
    }
}
