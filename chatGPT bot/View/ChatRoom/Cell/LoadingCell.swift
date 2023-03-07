//
//  LoadingCell.swift
//  chatGPT bot
//
//  Created by 孔令傑 on 2023/3/7.
//

import UIKit
import Lottie

class LoadingCell: UITableViewCell, ChatCell {
    
    let backView = UIView()
    let screenWidth = UIScreen.main.bounds.width
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setUpBackView()
        setUpLottie()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(data: ContentInfo) {
    }
    
    func setUpBackView() {
        backView.layer.cornerRadius = 10
        backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        backView.backgroundColor = UIColor.asset(.botChat)
        backView.frame = CGRect(x: 10, y: 0, width:screenWidth*0.3 , height: screenWidth*0.1)
        contentView.addSubview(backView)
    }

    func setUpLottie() {
        let animationView = LottieAnimationView(name: "loading")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.frame = backView.bounds
        animationView.animationSpeed = 1
        backView.addSubview(animationView)
        animationView.play()
    }
}
