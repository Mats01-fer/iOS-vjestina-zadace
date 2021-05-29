//
// Created by Matej Butkovic on 14.05.2021..
//

import Foundation
import UIKit

protocol QuizzesPresenterProtocol: UIViewController {
    func showQuizzes(allQuizzes: [Quiz])
}

class QuizzesPresenter {
    weak var view: QuizzesPresenterProtocol?
    var networkService: NetworkServiceProtocol!

    init(with view: QuizzesPresenterProtocol){
        self.view = view
        networkService = NetworkService()
    }

    func fetchQuizzes() {
        networkService.fetchQuizzes { [weak self] (result: Result<QuizzesResponse, RequestError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(_):
                return

            case .success(let value):
                DispatchQueue.main.async {
                    self.view?.showQuizzes(allQuizzes: value.quizzes)
                }
            }
        }
    }

}
