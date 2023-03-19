//
//  UIColor+Ex.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/4.
//

import UIKit

enum assetColor: String {
    case ChatBackColor
    case botChat
    case userChat
}

extension UIColor {
    static func asset(_ asset: assetColor) -> UIColor? {
        return UIColor(named: asset.rawValue)
    }
}
