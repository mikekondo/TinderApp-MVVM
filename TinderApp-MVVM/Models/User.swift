//
//  User.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/25.
//

import Foundation
import Firebase

class User{

    var email: String
    var name: String
    var createdAt: Timestamp

    init(dic: [String: Any]){
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
