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
    private var lastNumberOfLinesWithText = 1
    let originTextViewHeight = CGFloat(40)
    private var promptTextViewHeight = CGFloat(40)
    private var promptHeightAnchor = NSLayoutConstraint()
    private let maximumLine = 5
    
    var isValid: Bool = false {
        didSet {
            switchButtonStatus(canBeOpend: isValid)
        }
    }
    
    init() {
        super.init(frame: .zero)
        promptTextView.delegate = self
        backgroundColor = UIColor.asset(.ChatBackColor)
        addSubViews()
        setConstraints()
        setUpLook()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
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
    
    private func setConstraints() {
        promptHeightAnchor = promptTextView.heightAnchor.constraint(equalToConstant: originTextViewHeight)
        
        NSLayoutConstraint.activate([
            senderBackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            senderBackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            senderStack.centerXAnchor.constraint(equalTo: senderBackView.centerXAnchor),
            senderStack.topAnchor.constraint(equalTo: senderBackView.topAnchor, constant: 10),
            senderStack.bottomAnchor.constraint(equalTo: senderBackView.bottomAnchor, constant: 10),
            
            promptTextView.widthAnchor.constraint(equalTo: senderBackView.widthAnchor, multiplier: 0.7),
            promptHeightAnchor,
            
            sendButton.widthAnchor.constraint(equalTo: senderBackView.widthAnchor, multiplier: 0.15),
            
            chatTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: senderBackView.topAnchor),
            chatTableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func setUpLook() {
        backgroundColor = .black
        senderStack.spacing = 15
        senderStack.axis = .horizontal
        
        promptTextView.backgroundColor = UIColor.asset(.messageField)
        promptTextView.font = UIFont.systemFont(ofSize: 16)
        promptTextView.layer.cornerRadius = 4
        promptTextView.layer.masksToBounds = true
        promptTextView.layer.borderWidth = 1
        promptTextView.textContainerInset = UIEdgeInsets(top: 10,
                                                         left: 5,
                                                         bottom: 4,
                                                         right: 5)
        
        senderBackView.backgroundColor = UIColor.asset(.ChatBackColor)
        
        sendButton.backgroundColor = .systemGray3
        sendButton.layer.cornerRadius = 15
        sendButton.setTitle("send", for: .normal)
        sendButton.isEnabled = false
    }
    
    private func switchButtonStatus(canBeOpend: Bool) {
        if canBeOpend {
            sendButton.backgroundColor = .systemPink
            sendButton.isEnabled = true
        } else {
            sendButton.backgroundColor = .systemGray3
            sendButton.isEnabled = false
        }
    }
    
    func renewView(numOfRow: Int) {
        if numOfRow > 0 {
            chatTableView.scrollToRow(at: IndexPath(row: numOfRow-1, section: 0),
                                      at: .top,
                                      animated: true)
        }
    }
    
    func heightForTextView(_ textView: UITextView, with currentLines: Int) -> CGFloat {
        let change = currentLines - lastNumberOfLinesWithText
        let additionHeight = textView.font!.lineHeight*CGFloat(change)
        return promptTextViewHeight + additionHeight
    }
    
    func animateInputBox(to height: CGFloat) {
    
        UIView.animate(withDuration: 0) { [weak self] in
            guard let self = self else { return }
            self.promptHeightAnchor.constant = height
            self.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.promptTextViewHeight = height
        }
        
        if height == originTextViewHeight {
            lastNumberOfLinesWithText = 1
        }
    }
}

extension ChatBaseView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        var numberOfLines: Int
        var newHeight: CGFloat
        numberOfLines = Int(textView.contentSize.height/textView.font!.lineHeight)
        newHeight = heightForTextView(textView, with: numberOfLines)
        
        if numberOfLines+lastNumberOfLinesWithText < maximumLine*2 {
            animateInputBox(to: newHeight)
        }
        lastNumberOfLinesWithText = numberOfLines
    }
}
