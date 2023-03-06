//
//  ViewController.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit
import Combine

class ChatRoomViewController: UIViewController {
    
    private lazy var chatBaseView = ChatBaseView()
    private let chatViewModel = ChatViewModel()
    private var bindings = [AnyCancellable]()
    private var sentText = ""
    
    typealias DataSource = UITableViewDiffableDataSource<Int, ContentInfo>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, ContentInfo>
    private lazy var dataSource = createDataSource()
    private var contents: [ContentInfo] = []
    
    var bottomConstraints = NSLayoutConstraint()
    var topConstraints = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.asset(.ChatBackColor)
        addCustomViews()
        setConstraints()
        setUpBindings()
        setTarget()
    }
    
    private func addCustomViews() {
        view.addSubview(chatBaseView)
    }
    
    private func setConstraints() {
        chatBaseView.translatesAutoresizingMaskIntoConstraints = false
        topConstraints = chatBaseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        bottomConstraints = chatBaseView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraints,
            bottomConstraints,
            chatBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setTarget() {
        chatBaseView.sendButton.addTarget(self, action: #selector(tryToSendMessage), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touch))
        tap.cancelsTouchesInView = false
        chatBaseView.chatTableView.addGestureRecognizer(tap)
    }
    
    private func createDataSource() -> DataSource {
        return DataSource(tableView: chatBaseView.chatTableView) {
            tableView, indexPath, data in
            let type = data.type
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type.cellIdentifier, for: indexPath) as? ChatCell else {
                fatalError("error of dequeuing ChatCell")
            }
            cell.configure(data: self.contents[indexPath.row])
            return cell
        }
    }
    
    private func configureSnapshot() {
        var snapShot = SnapShot()
        snapShot.appendSections([0])
        snapShot.appendItems(contents)
        dataSource.apply(snapShot, animatingDifferences: true)
        chatBaseView.renewView(numOfRow: contents.count)
    }
    
    private func setUpBindings() {
        keyboardFrameSubscription
            .store(in: &bindings)
        
        func bindViewToViewModel() {
            chatBaseView.promptTextView.textViewPublisher
                .assign(to: \.prompt, on: chatViewModel)
                .store(in: &bindings)
            
            chatBaseView.promptTextView.textViewPublisher
                .sink { [weak self] message in
                    guard let self = self else { return }
                    self.sentText = message
                }
                .store(in: &bindings)
            
        }
        
        func bindViewModelToView() {
            chatViewModel.promptIsEmpty
                .map { !$0 }
                .assign(to: \.isValid, on: chatBaseView)
                .store(in: &bindings)
            
            chatViewModel.reply
                .receive(on: DispatchQueue.main)
                .sink { [weak self] reply in
                    guard let self = self else { return }
                    let info = ContentInfo(type: .fromBot, data: reply)
                    self.contents.append(info)
                    self.configureSnapshot()
                }
                .store(in: &bindings)
                
        }
        
        bindViewModelToView()
        bindViewToViewModel()
    }
    
    @objc func tryToSendMessage() {
        let info = ContentInfo(type: .fromUser, data: sentText)
        contents.append(info)
        configureSnapshot()
        chatBaseView.promptTextView.text = ""
        chatBaseView.animateInputBox(to: 0)
        chatViewModel.getBotResponse()
    }
    
    @objc private func touch() {
        view.endEditing(true)
    }
}

extension ChatRoomViewController: KeyboardHandling {
    func keyboardWillChangeFrame(yOffset: CGFloat, duration: TimeInterval, animationCurve: UIView.AnimationCurve) {
        bottomConstraints.isActive = false
        UIViewPropertyAnimator(duration: duration, curve: animationCurve) { [weak self] in
            guard let self = self else { return }
            self.bottomConstraints = self.chatBaseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.safeAreaInsets.bottom + yOffset)
            self.bottomConstraints.isActive = true
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
}

