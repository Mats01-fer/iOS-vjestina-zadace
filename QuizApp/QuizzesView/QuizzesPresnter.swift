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
    var networkService: NetworkService!

    init(with view: QuizzesPresenterProtocol){
        self.view = view
        networkService = NetworkService()
    }

    func fetchQuizes() {
        networkService.fetchQuizes(view: view)
    }

}
