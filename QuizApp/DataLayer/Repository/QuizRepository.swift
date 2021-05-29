//
// Created by Matej Butkovic on 29.05.2021..
//

import Foundation
import Reachability

class QuizRepository {

    private let databaseDataSource: QuizDatabaseDataSource
    private let networkDataSource: QuizNetworkDataSource

    init(databaseDataSource: QuizDatabaseDataSource, networkDataSource: QuizNetworkDataSource) {
        self.databaseDataSource = databaseDataSource
        self.networkDataSource = networkDataSource
    }

    func fetchQuizzesFromRemote(completionHandler: @escaping (Result<[Quiz], RequestError>) -> Void) {
        networkDataSource.fetchQuizzes { [weak self] (result: Result<QuizzesResponse, RequestError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))

            case .success(let value):
                completionHandler(.success(self.getLocalQuizzes()))

            }
        }

    }

    func getLocalQuizzes() -> [Quiz] {
        print("I am getting you some quizzes from local storage")
        return []
    }


}