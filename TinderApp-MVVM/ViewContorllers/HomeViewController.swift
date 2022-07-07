//
//  ViewController.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/05.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let topControlView = TopControlView()
        let cardView = CardView() // cardView

        let bottomControlView = BottomControlView()

        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControlView])
        // stackViewのレイアウトを可能にする処理
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        self.view.addSubview(stackView)

        // stackViewのオートレイアウト的なやつ
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach({$0.isActive = true})
    }


}

