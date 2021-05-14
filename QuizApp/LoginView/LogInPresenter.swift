//
//  LogInPresenter.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation
import UIKit

protocol LoginPresenterProtocol: UIViewController {
    func loginSuccess()
    func loginFail()
}

class LoginPresenter {
    weak var view: LoginPresenterProtocol?
    var networkService: NetworkService!
    
    init(with view: LoginPresenterProtocol){
        self.view = view
        networkService = NetworkService()
    }
    
    func login(email: String, password: String) {
        networkService.login(email: email, password: password, view: view)
    }
    
}

