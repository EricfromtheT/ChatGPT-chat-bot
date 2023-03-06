//
//  KeyBoardHandling.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/4.
//

import UIKit
import Combine

protocol KeyboardHandling: AnyObject {
    func keyboardWillChangeFrame(yOffset: CGFloat, duration: TimeInterval, animationCurve: UIView.AnimationCurve)
}

extension KeyboardHandling where Self: UIViewController {
    var keyboardFrameSubscription: AnyCancellable {
        return NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap(\.userInfo)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] userInfo in
                self?.handle(userInfo: userInfo)
            }
    }

    var bottomInset: CGFloat {
        view.safeAreaInsets.bottom
    }

    private func handle(userInfo: [AnyHashable: Any]) {
        guard
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration: TimeInterval =
                (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let animationCurveRaw = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
            let animationCurve = UIView.AnimationCurve(rawValue: animationCurveRaw)
        else { return }

        let endFrameY = endFrame.origin.y

        var yOffset = CGFloat(0)
        if endFrameY < UIScreen.main.bounds.size.height {
            // 鍵盤上升高度
            yOffset = -(endFrame.size.height - bottomInset/3)
        }
        keyboardWillChangeFrame(yOffset: yOffset, duration: duration, animationCurve: animationCurve)
    }
}
