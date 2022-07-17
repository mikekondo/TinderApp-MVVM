//
//  ResisterViewController.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/09.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController{

    private let disposeBag = DisposeBag()


    // MARK: UIViews
    private let titleLabel = ResisterTitleLabel()

     private let nameTextField = RegisterTextField(placeHolder: "名前")
//    let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
    private let emailTextField = RegisterTextField(placeHolder: "email")
//    let emailTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "email"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
    private let passwordTextField = RegisterTextField(placeHolder: "パスワード")
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placehxolder = "パスワード"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
    private let registerButton = RegisterButton()

//    let registerButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("登録", for: .normal)
//        button.backgroundColor = .red
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }

    // MARK: Methods
    private func setupGradientLayer(){
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        layer.colors = [startColor,endColor]
        layer.locations = [0.0,1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }

    private func setupLayout(){
        passwordTextField.isSecureTextEntry = true
        view.backgroundColor = .yellow

        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)

        nameTextField.anchor(height: 45)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor,bottomPadding: 20)
        baseStackView.anchor(left: view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,height: 200,leftPadding: 40,rightPadding: 40)
    }

    private func setupBindings(){

        // 循環参照を防ぐためにweak selfをつけるb
        nameTextField.rx.text.asDriver().drive { [weak self] text in
            // textの情報ハンドル
        }
        .disposed(by: disposeBag)

        emailTextField.rx.text.asDriver().drive { [weak self] text in
            // textの情報ハンドル
        }
        .disposed(by: disposeBag)

        passwordTextField.rx.text.asDriver().drive { [weak self] text in
            // textの情報ハンドル
        }
        .disposed(by: disposeBag)

        registerButton.rx.tap.asDriver().drive { [weak self] _ in
            // 登録時の処理
            print("タップ処理反映されてる？")
            self?.createUserToFireAuth()
        }
        .disposed(by: disposeBag)
    }

    private func createUserToFireAuth(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else{ return }

        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err{
                print("auth情報の保存に失敗",err)
                return
            }

            guard let uid = auth?.user.uid else { return }
            print("auth情報の保存に成功",uid)
        }

    }

}

