//
//  NetworkService.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}


class NetworkService: NetworkServiceProtocol {

    private func executeUrlRequestNoResponse<String: Decodable>(_ request: URLRequest, completionHandler:
            @escaping (Result<String, RequestError>) -> Void) {

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in

            guard let httpResponse = response as? HTTPURLResponse
                    else {
                completionHandler(.failure(.serverError))
                return
            }
            if (httpResponse.statusCode == 200) {
                completionHandler(.success("Saved" as! String))
            }

        })

        task.resume()
    }


    private func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler:
            @escaping (Result<T, RequestError>) -> Void) {

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in

            guard let value = try? JSONDecoder().decode(T.self, from: data!) else {
                completionHandler(.failure(.dataDecodingError))
                return
            }
            completionHandler(.success(value))

        })

        task.resume()
    }


    func login(email: String, password: String, completionHandler: @escaping (Result<Login, RequestError>) -> Void) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(email)&password=\(password)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        executeUrlRequest(request, completionHandler: completionHandler)
    }

    func fetchQuizzes(completionHandler: @escaping (Result<QuizzesResponse, RequestError>) -> Void) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        executeUrlRequest(request, completionHandler: completionHandler)
    }

    func postQuizResults(results: QuizResult) {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/result") else {
            return
        }
        let defaults = UserDefaults.standard

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(defaults.string(forKey: "token") ?? "", forHTTPHeaderField: "Authorization")

        let jsonData = try! JSONEncoder().encode(results)
        request.httpBody = jsonData
        executeUrlRequestNoResponse(request) { (result: Result<String, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
                return

            case .success(_):
                print("saved quiz result")
            }
        }
    }


}

