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


    func executeUrlRequestNoResponse<String: Decodable>(_ request: URLRequest, completionHandler:
            @escaping (Result<String, RequestError>) -> Void) {

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in

            guard let httpResponse = response as? HTTPURLResponse
                    else {
                completionHandler(.failure(.serverError))
                return
            }
            if(httpResponse.statusCode == 200) {
                completionHandler(.success("Saved" as! String))
            }

        })

        task.resume()
    }


    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler:
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


    func login(email: String, password: String, view: LoginPresenterProtocol?) -> Void {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/session?username=\(email)&password=\(password)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        executeUrlRequest(request) { (result: Result<Login, RequestError>) in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    view?.loginFail()

                }

            case .success(let value):
                let defaults = UserDefaults.standard
                defaults.set(value.userId, forKey: "userId")
                defaults.set(value.token, forKey: "token")
                DispatchQueue.main.async {
                    view?.loginSuccess()
                }


            }
        }


    }

    func fetchQuizes(view: QuizzesPresenterProtocol?) -> Void {
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        executeUrlRequest(request) { (result: Result<QuizzesResponse, RequestError>) in
            switch result {
            case .failure(_):
                return

            case .success(let value):
                DispatchQueue.main.async {
                    view?.showQuizzes(allQuizzes: value.quizzes)
                }
            }
        }
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

