//
//  Firebase-Extension.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/20.
//

import UIKit
import Firebase

// MARK: 
extension Auth {
    static func createUserToFireAuth(email: String?,password: String?,name: String,completion: @escaping (Bool) -> Void){
        guard let email = email else { return }
        guard let password = password else{ return }

        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err{
                print("auth情報の保存に失敗",err)
                return
            }

            guard let uid = auth?.user.uid else { return }
            Firestore.setUserDataToFireStore(email: email, uid: uid,name: name){ (success) in
               completion(success)
            }
        }
    }

}

// MARK: - FireStore
extension Firestore {
    static func setUserDataToFireStore(email: String,uid: String,name: String?,completion: @escaping (Bool) -> ()){
        guard let name = name else{ return }
        let document: Dictionary<String,Any> = ["name": name,"email": email,"createdAt": Timestamp()]
        Firestore.firestore().collection("users").document(uid).setData(document) { error in
            if let error = error{
                print("ユーザ情報の保存に失敗",error)
                return
            }
            completion(true)
            print("ユーザ情報の保存に成功")
        }
    }
}
