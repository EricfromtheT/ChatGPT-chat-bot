//
//  UITextView+Ex.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/3.
//

import UIKit
import Combine

extension UITextView {
    var textViewPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification)
            .compactMap { $0.object as? UITextView }
            .compactMap(\.text)
            .eraseToAnyPublisher()
    }
}
