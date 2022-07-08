//
//  CardInfoLabel.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/08.
//

import UIKit
class CardInfoLabel: UILabel{

    // nopeとgoodのラベル
    init(frame: CGRect,labelText: String,labelColor: UIColor){
        super.init(frame: frame)

        font = .boldSystemFont(ofSize: 45)
        text = labelText
        textColor = .rgb(red: 222, green: 110, blue: 110)
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        alpha = 0
        textAlignment = .center
    }


    // その他のtextのラベル
    init(frame: CGRect,labelText: String,labelFont: UIFont){
        super.init(frame: frame)
        font = labelFont
        text = labelText
        textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
