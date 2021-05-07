//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizViewController: UIViewController {

    private var viewBox: UIView!
    private var quizNameLabel: UILabel!
    private var quizDescriptionLabel: UILabel!
    private var quizImage: UIImageView!
    private var startButton: UIButton!

    private var quiz: Quiz!

    private var router: AppRouter!

    @objc private func startQuiz(_ sender: Any) {

        router.showQuestion(questions: quiz.questions, index: 0)
    }

    convenience init(router: AppRouter, quiz: Quiz) {
        self.init()
        self.quiz = quiz
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = quiz.title

        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        viewBox = UIView()
        viewBox.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)

        quizNameLabel = UILabel()
        quizNameLabel.text = quiz.title
        quizNameLabel.textColor = .white
        quizNameLabel.textAlignment = .center
        quizNameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)

        quizDescriptionLabel = UILabel()
        quizDescriptionLabel.text = quiz.description
        quizDescriptionLabel.textColor = .white
        quizDescriptionLabel.textAlignment = .center
        quizDescriptionLabel.font = UIFont.systemFont(ofSize: 14.0)

        quizImage = UIImageView(image: UIImage(named: "questionmark"))
        quizImage.layer.cornerRadius = 10
        quizImage.clipsToBounds = true

        startButton = UIButton()
        startButton.addTarget(self, action: #selector(self.startQuiz), for: .touchUpInside)
        startButton.setTitleColor(.black, for: .normal)
        startButton.setTitle("Start Quiz", for: .normal)
        startButton.backgroundColor = .white
        startButton.tintColor = .purple

        viewBox.addSubview(quizNameLabel)
        viewBox.addSubview(quizDescriptionLabel)
        viewBox.addSubview(quizImage)
        viewBox.addSubview(startButton)

        view.addSubview(viewBox)
    }

    private func addConstraints() {
        let height = view.bounds.height
        let width = view.bounds.width

        viewBox.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview().offset(height * 0.25)
            make.left.equalToSuperview().offset(width * 0.025)
        }
        viewBox.layer.cornerRadius = 10
        viewBox.layer.masksToBounds = true

        quizNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview()
        }
        quizDescriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.width.equalToSuperview()
        }
        quizImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        startButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        startButton.layer.cornerRadius = 20

    }
}
