//
//  ResisterViewController.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/09.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class RegisterViewController: UIViewController{

    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    private let alreadyHaveAccountButton = UIButton(type: .system).createAboutButton(text: "既にアカウントをお持ちの方はこちら")

    // MARK: UIViews
    private let titleLabel = ResisterTitleLabel(text: "Tinder")

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
    private let registerButton = RegisterButton(text: "登録")

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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

        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)

        nameTextField.anchor(height: 45)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor,bottomPadding: 20)
        baseStackView.anchor(left: view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,height: 200,leftPadding: 40,rightPadding: 40)
        alreadyHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor,topPadding: 20)
    }

    private func setupBindings(){
        // textFieldのバインディング
        // 循環参照を防ぐためにweak selfをつけるb
        nameTextField.rx.text.asDriver().drive { [weak self] text in
            self?.viewModel.nameTextInput.onNext(text ?? "")
            // textの情報ハンドル
        }
        .disposed(by: disposeBag)

        emailTextField.rx.text.asDriver().drive { [weak self] text in
            self?.viewModel.emailTextInput.onNext(text ?? "")
            // textの情報ハンドル
        }
        .disposed(by: disposeBag)

        passwordTextField.rx.text.asDriver().drive { [weak self] text in
            self?.viewModel.passwordTextInput.onNext(text ?? "")
            // textの情報ハンドル
        }
        .disposed(by: disposeBag)

        registerButton.rx.tap.asDriver().drive { [weak self] _ in
            // 登録時の処理
            self?.createUser()
        }
        .disposed(by: disposeBag)

        // ボタンのバインディング
        alreadyHaveAccountButton.rx.tap.asDriver().drive { [weak self] _ in
            let login = LoginViewController()
            self?.navigationController?.pushViewController(login, animated: true)
        }
        .disposed(by: disposeBag)


        // viewModelのバインディング
        viewModel.validRegisterDriver.drive { validAll in
            print("validAll: ",validAll)
            self.registerButton.isEnabled = validAll
            self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7,alpha: 1)
        }
        .disposed(by: disposeBag)
    }

    private func createUser(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let name = nameTextField.text ?? ""

        HUD.show(.progress)
        Auth.createUserToFireAuth(email: email, password: password, name: name){(success) in
            HUD.hide()
            if success{
                print("処理が完了")
                self.dismiss(animated: true, completion: nil)
            }else{
                print("ユーザ登録失敗")
            }

        }
    }

//    private func createUserToFireAuth(){
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else{ return }
//
//        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
//            if let err = err{
//                print("auth情報の保存に失敗",err)
//                return
//            }
//
//            guard let uid = auth?.user.uid else { return }
//            self.setUserDataToFireStore(email: email, uid: uid)
//        }
//    }
//
    
//    private func setUserDataToFireStore(email: String,uid: String){
//        guard let name = nameTextField.text else{ return }
//        let document: Dictionary<String,Any> = ["name": name,"email": email,"createdAt": Timestamp()]
//        Firestore.firestore().collection("users").document(uid).setData(document) { error in
//            if let error = error{
//                print("ユーザ情報の保存に失敗",error)
//                return
//            }
//            print("ユーザ情報の保存に成功")
//        }
//    }

}

