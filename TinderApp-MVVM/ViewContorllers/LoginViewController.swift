//
//  LoginViewController.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/24.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class LoginViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    // MARK: UIViews
    private let titleLabel = ResisterTitleLabel(text: "LOGIN")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "パスワード")
    private let loginButton = RegisterButton(text: "ログイン")
    private let dontHaveAccountButton = UIButton(type: .system).createAboutButton(text: "アカウントをお持ちでない方はこちら")


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        setupGradientLayer()
        setupLayout()
        setupBindings()
        
    }

    private func setupLayout(){
        passwordTextField.isSecureTextEntry = true

        let baseStackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAccountButton)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor,bottomPadding: 20)
        baseStackView.anchor(left: view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,height: 200,leftPadding: 40,rightPadding: 40)
        dontHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor,topPadding: 20)
    }

    private func setupGradientLayer(){
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        layer.colors = [startColor,endColor]
        layer.locations = [0.0,1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }

    private func setupBindings(){
        dontHaveAccountButton.rx.tap.asDriver().drive { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)

        loginButton.rx.tap.asDriver().drive{ [weak self] _ in
            self?.loginWithFireAuth()
        }
        .disposed(by: disposeBag)
    }

    private func loginWithFireAuth(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { res, error in
            if let error = error{
                print("ログインに失敗",error)
                return
            }
            print("ログインに成功")
            self.dismiss(animated: true,completion: nil)
        }
    }

}
