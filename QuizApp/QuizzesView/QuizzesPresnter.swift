//
// Created by Matej Butkovic on 14.05.2021..
//

import Foundation
import UIKit

protocol QuizzesPresenterProtocol: UIViewController {
    func showQuizzes(allQuizzes: [Quiz])
}

class QuizzesPresenter {
    var networkService: NetworkServiceProtocol!
    private var repository: QuizRepository?
    private var router: AppRouterProtocol!
    private weak var view: QuizzesPresenterProtocol?

    init(router: AppRouterProtocol, repository: QuizRepository) {
        self.router = router
        networkService = NetworkService()
        self.repository = repository
    }

    func setView(view: QuizzesPresenterProtocol){
        self.view = view
    }

    func fetchQuizzes() {
//        networkService.fetchQuizzes { [weak self] (result: Result<QuizzesResponse, RequestError>) in
//            guard let self = self else {
//                return
//            }
//            switch result {
//            case .failure(_):
//                return
//
//            case .success(let value):
//                DispatchQueue.main.async {
//                    self.view?.showQuizzes(allQuizzes: value.quizzes)
//                }
//            }
//        }

        guard let repository = repository else {
            return
        }

        if (false) {
            repository.fetchQuizzesFromRemote { [weak self] (result: Result<[Quiz], RequestError>) in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure(_):
                    return

                case .success(let value):
                    DispatchQueue.main.async {
                        self.view?.showQuizzes(allQuizzes: value)
                    }
                }
            }

        } else {
            let quizzes = repository.getLocalQuizzes()
            DispatchQueue.main.async {
                self.view?.showQuizzes(allQuizzes: quizzes)
            }
        }

    }

    func showQuiz(quiz: Quiz){
        self.router.showQuiz(quiz: quiz)
    }

}
