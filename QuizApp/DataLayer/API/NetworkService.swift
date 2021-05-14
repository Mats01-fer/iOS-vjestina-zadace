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


class NetworkService {

    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler:
            @escaping (Result<T, RequestError>) -> Void) {

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                print(response!)
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                guard let value = try? JSONDecoder().decode(T.self, from: data!) else {
                    completionHandler(.failure(.dataDecodingError))

                    return
                }
                completionHandler(.success(value))
            } catch {
                completionHandler(.failure(.clientError))
            }
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
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    view?.loginFail()
                }
                
            case .success(let value):
                print(value)
                DispatchQueue.main.async {
                    view?.loginSuccess()
                }
                
                
            }
        }



    }

    func fetchQuizes() -> [Quiz] {
        let dataService = DataService()
        return dataService.fetchQuizes()
    }


}

