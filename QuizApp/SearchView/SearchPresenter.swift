//
//  SearchPresenter.swift
//  QuizApp
//
//  Created by Matej Butkovic on 30.05.2021..
//

import Foundation
import UIKit

protocol SearchPresnterDelegate: UIViewController {
    func showQuizzes(allQuizzes: [Quiz])
}

class SearchPresenter {
    var networkService: NetworkServiceProtocol!
    private var repository: QuizRepository?
    private var router: AppRouterProtocol!
    private weak var view: SearchPresnterDelegate?

    init(router: AppRouterProtocol, repository: QuizRepository) {
        self.router = router
        networkService = NetworkService()
        self.repository = repository
    }

    func setView(view: SearchPresnterDelegate){
        self.view = view
    }
    
    

    func fetchQuizzes(name: String) {

        guard let repository = repository else {
            return
        }
        
        let quizzes = repository.getLocalQuizzes(name: name)
        self.view?.showQuizzes(allQuizzes: quizzes)
    }

    func showQuiz(quiz: Quiz){
        self.router.showQuiz(quiz: quiz)
    }

}
