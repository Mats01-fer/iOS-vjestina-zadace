//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    func login(email: String, password: String) -> LoginStatus
    func fetchQuizes() -> [Quiz]
}
