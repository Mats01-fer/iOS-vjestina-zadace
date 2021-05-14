//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {

    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) -> Void

}
