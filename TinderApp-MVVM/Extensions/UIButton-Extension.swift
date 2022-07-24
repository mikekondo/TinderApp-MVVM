//
//  UIButton-Extension.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/24.
//

import UIKit
extension UIButton{
    func createAboutButton(text: String) -> UIButton{
        self.setTitle("\(text)", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14)
        return self
    }
}
