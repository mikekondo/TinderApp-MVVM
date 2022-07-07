//
//  CardView.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/07.
//

import UIKit
class CardView: UIView{

    let cardImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleToFill
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.text = "Taro, 22"
        label.textColor = .white
        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    let residenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "日本、大阪"
        label.textColor = .white
        return label
    }()

    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.text = "ランニング"
        label.textColor = .white
        return label
    }()

    let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.text = "走り回るのが大好きです"
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        // panGestureRecognizerは初めて聞いた
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }

    @objc private func panCardView(gesture: UIPanGestureRecognizer){
        let trancslation = gesture.translation(in: self)
        if gesture.state == .changed{
            self.transform = CGAffineTransform(translationX: trancslation.x, y: trancslation.y)
        }else if gesture.state == .ended{
            UIView.animate(withDuration: 0.3){
                self.transform = .identity
                self.layoutIfNeeded()
            }
        }
    }

    private func setupLayout(){
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel,hobbyLabel,introductionLabel])
        infoVerticalStackView.axis = .vertical

        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView,infoButton])
        baseStackView.axis = .horizontal

        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        cardImageView.anchor(top: topAnchor,bottom: bottomAnchor,left: leftAnchor,right: rightAnchor,leftPadding: 10,rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor,left: cardImageView.leftAnchor,right: cardImageView.rightAnchor,bottomPadding: 20,leftPadding: 20,rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor,left: cardImageView.leftAnchor,bottomPadding: 10,leftPadding: 20)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
