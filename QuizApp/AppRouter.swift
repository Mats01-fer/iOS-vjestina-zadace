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

    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)

        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

    func backToLogin() {
        let vc = LoginViewController(router: self)
        navigationController.setViewControllers([vc], animated: false) // replace root viewcontroller

    }

    func showQuizzes() {

        let qc = QuizzesViewController(router: self)
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

    func showQuestion(questions: [Question], index: Int) {
        navigationController?.pushViewController(QuestionViewController(
                router: self, _questions: questions, _index: index),
                animated: true)
    }

    func showNextQuestion(questions: [Question], index: Int, progressBar: QuestionTrackerView) {
        if (questions.count > index) {
            navigationController?.pushViewController(QuestionViewController(
                    router: self, _questions: questions, _index: index, progressBar: progressBar),
                    animated: true)

        } else {
            navigationController.pushViewController(QuizResultViewController(router: self, progress: progressBar), animated: true)
        }

    }
}
