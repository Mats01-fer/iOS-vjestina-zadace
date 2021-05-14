//
//  NetworkService.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation


class NetworkService: NetworkServiceProtocol {
    func login(email: String, password: String) -> LoginStatus {
        
        
        
        return .error(401, "Unauthorised.")

    }
    
    func fetchQuizes() -> [Quiz] {
        return []
    }
    
    
    
}

