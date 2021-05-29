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
    func showQuizzes()
    func backToLogin()
    func showQuiz(quiz: Quiz)
}

class AppRouter: AppRouterProtocol {
    private var navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        self.navigationController.navigationBar.barTintColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 0)
    }

    func setStartScreen(in window: UIWindow?) {
        let lp = LoginPresenter(router: self)
        let vc = LoginViewController(presenter: lp)

        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

    func backToLogin() {
        let lp = LoginPresenter(router: self)
        let vc = LoginViewController(presenter: lp)
        navigationController.setViewControllers([vc], animated: false) // replace root viewcontroller

    }

    func showQuizzes() {
        let repo = QuizRepository(databaseDataSource: QuizDatabaseDataSource(), networkDataSource: QuizNetworkDataSource())
        let qc = QuizzesViewController(presenter: QuizzesPresenter(router: self, repository: repo))
        let sc = SettingsViewController(router: self)

        qc.tabBarItem.image = UIImage(named: "quizzes")
        sc.tabBarItem.image = UIImage(named: "settings")


        let tabbedController = UITabBarController()
        tabbedController.title = "PopQuiz"

        tabbedController.viewControllers = [qc, sc]
        navigationController.setViewControllers([tabbedController], animated: false) // replace root viewcontroller

    }

    func showQuiz(quiz: Quiz) {
        navigationController?.pushViewController(QuizViewController(
                router: self,
                quiz: quiz),
                animated: true)
    }

    func showQuestion(questions: Quiz, index: Int) {
        navigationController?.pushViewController(QuestionViewController(
                router: self, quiz: questions, _index: index),
                animated: true)
    }

    func showResults(correct: Int, total: Int) {
        navigationController.pushViewController(QuizResultViewController(router: self, correct: correct, total: total), animated: true)
    }
}
