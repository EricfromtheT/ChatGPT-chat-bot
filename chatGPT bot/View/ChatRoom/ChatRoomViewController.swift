//
//  ViewController.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    private lazy var chatBaseView = ChatBaseView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomViews()
        setConstraints()
    }
    
    private func addCustomViews() {
        view.addSubview(chatBaseView)
    }
    
    private func setConstraints() {
        chatBaseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chatBaseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatBaseView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            chatBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

