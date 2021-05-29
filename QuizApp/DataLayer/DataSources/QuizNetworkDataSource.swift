//
// Created by Matej Butkovic on 29.05.2021..
//

import Foundation

class QuizNetworkDataSource {

    var networkService: NetworkServiceProtocol!

    init(){
        networkService = NetworkService()
    }

    func fetchQuizzes(completionHandler: @escaping (Result<QuizzesResponse, RequestError>) -> Void) {
        networkService.fetchQuizzes(completionHandler: completionHandler)
    }


}
