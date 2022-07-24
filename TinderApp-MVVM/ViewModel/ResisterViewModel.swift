//
//  ResisterViewModel.swift
//  TinderApp-MVVM
//
//  Created by 近藤米功 on 2022/07/18.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInputs{
    var nameTextInput: AnyObserver<String> { get }
    var emailTextInput: AnyObserver<String> { get }
    var passwordTextInput: AnyObserver<String> { get }
}

protocol RegisterViewModelOutputs{
    var nameTextOutput: PublishSubject<String> { get }
    var emailTextOutput: PublishSubject<String> { get }
    var passwordTextOutput: PublishSubject<String> { get }

}

// 監視
class RegisterViewModel: RegisterViewModelInputs,RegisterViewModelOutputs{

    private let disposeBag = DisposeBag()

    // MARK: Observable：観察可能（viewModelから出ていく情報）
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)

    // MARK: Observer：観察者（viewModelに入ってくる情報）
    var nameTextInput: AnyObserver<String>{
        nameTextOutput.asObserver()
    }

    var emailTextInput: AnyObserver<String>{
        emailTextOutput.asObserver()
    }

    var passwordTextInput: AnyObserver<String>{
        passwordTextOutput.asObserver()
    }

    var validRegisterDriver: Driver<Bool> = Driver.never()

    init(){

        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())

        // テキストの文字数が5以下ならnameValidにはfalseが入る、5以上ならtrue
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
//            .subscribe { text in
//            print("name:",text)
//        }
//        .disposed(by: disposeBag)

        let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
//            .subscribe { text in
//            print("email:",text)
//        }
//        .disposed(by: disposeBag)

        let passwordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }
//            .subscribe { text in
//            print("password:",text)
//        }
//        .disposed(by: disposeBag)

        // $0,$1,$2の中が全部trueならvalidAllにtrueが入る
        Observable.combineLatest(nameValid, emailValid, passwordValid) { $0 && $1 && $2}
            .subscribe { validAll in
                self.validRegisterSubject.onNext(validAll)
            }
            .disposed(by: disposeBag)

    }

}
