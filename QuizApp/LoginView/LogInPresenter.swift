//
//  LogInPresenter.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation
import UIKit



class LoginPresenter {
    weak var delegate: LoginPresenterDelegate?
    private var router: AppRouterProtocol!
    var networkService: NetworkServiceProtocol!

    init( router: AppRouterProtocol) {
        self.router = router
        networkService = NetworkService()
    }

    func setDelegate(delegate: LoginPresenterDelegate){
        self.delegate = delegate
    }


    func login(email: String, password: String) {
        networkService.login(email: email, password: password) { [weak self] (result: Result<Login, RequestError>) in
            guard let self = self else {
                return
            }

            switch result {
            case .failure(_):
                self.loginFail()
            case .success(let value):
                self.loginSuccess(value: value)
            }
        }
    }

    func loginFail() {
        DispatchQueue.main.async {
            self.delegate?.loginFail()
        }
    }

    func loginSuccess(value: Login) {
        let defaults = UserDefaults.standard
        defaults.set(value.userId, forKey: "userId")
        defaults.set(value.token, forKey: "token")
        DispatchQueue.main.async {
            self.delegate?.loginSuccess()
        }
    }

    func showQuizzes() {
        self.router.showQuizzes()
    }
}

