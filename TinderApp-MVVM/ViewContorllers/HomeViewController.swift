//
//  ViewController.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/05.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {

    private var user: User?

    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        Firestore.fetchUserFromFirestore(uid: uid) { user in
            guard let user = user else { return }
            self.user = user
        }
    }

//    private func fetchUserFromFirestore(uid: String){
//        let userDB = Firestore.firestore().collection("users").document("\(uid)")
//        userDB.getDocument { snapShot, error in
//            if let error = error{
//                print("getDocumentのエラー",error)
//            }
//
//        }
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Auth.auth().currentUser?.uid == nil{
            let registerController = RegisterViewController()
            registerController.modalPresentationStyle = .fullScreen
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }else{
            print("何もしない")
        }
    }

    private func setupLayout(){
        view.backgroundColor = .white
        let topControlView = TopControlView()
        let cardView = CardView() // cardView

        let bottomControlView = BottomControlView()

        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControlView])
        // stackViewのレイアウトを可能にする処理
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)

        // stackViewのオートレイアウト的なやつ
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach({$0.isActive = true})
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10,leftPadding: 10)

        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
    }

    @objc private func tappedLogoutButton(){
        do{
            try Auth.auth().signOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                let registerController = RegisterViewController()
                registerController.modalPresentationStyle = .fullScreen
                let nav = UINavigationController(rootViewController: registerController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }catch{
            print("ログアウトに失敗",error)
        }
    }


}

