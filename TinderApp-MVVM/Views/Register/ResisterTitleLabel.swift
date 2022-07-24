//
//  ResisterTitleLabel.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/17.
//

import UIKit

class ResisterTitleLabel: UILabel{
    init(text: String){
        super.init(frame: .zero)
        self.text = "\(text)"
        self.font = .boldSystemFont(ofSize: 80)
        self.textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
