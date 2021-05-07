//
//  AppRouterProtocol.swift
//  QuizApp
//
//  Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit

protocol AppRouterProtocol {

    func setStartScreen(in window: UIWindow?)
}

class AppRouter: AppRouterProtocol {
    private var navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        self.navigationController.navigationBar.barTintColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 0)
    }

    var window: UIWindow?

    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)

        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

    func showQuizzes() {
        let vc = QuizzesViewController(router: self)
        navigationController.setViewControllers([vc], animated: false) // replace root viewcontroller

    }

    func showQuiz(quiz: Quiz) {
        navigationController?.pushViewController(QuizViewController(
                router: self,
                quiz: quiz),
                animated: true)
    }

    func showQuestion(questions: [Question], index: Int) {
        if (questions.count > index + 1) {
            navigationController?.pushViewController(QuestionViewController(
                    router: self, _questions: questions, _index: index),
                    animated: true)

        } else {
            navigationController.pushViewController(QuizResultViewController(router: self), animated: true)
        }

    }
}
