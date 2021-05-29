//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    
    func login(email: String,
               password: String,
               completionHandler:
                @escaping (Result<Login, RequestError>) -> Void) -> Void
    
    func fetchQuizes(view: QuizzesPresenterProtocol?) -> Void
    
    func postQuizResults(results: QuizResult)

}
