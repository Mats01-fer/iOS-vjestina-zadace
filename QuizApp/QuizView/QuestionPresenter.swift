//
// Created by Matej Butkovic on 14.05.2021..
//

import Foundation
import UIKit


class QuestionPresenter {
    var networkService: NetworkService!

    init() {
        networkService = NetworkService()
    }


    func postQuizResults(results: QuizResult) {
        networkService.postQuizResults(results: results)
    }

}