//
// Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit
import SnapKit


class QuestionViewController: UIViewController {

    private var questionTextLabel: UILabel!

    private var questions: [Question]!
    private var index: Int!
    private var question: Question!
    private var answerButtons: [UIButton]!


    private var router: AppRouter!

    @objc private func back(sender: UIButton) {
        router.showQuizzes()
    }

    @objc private func nextQuestion(_ sender: Any) {
        router.showQuestion(questions: questions, index: self.index + 1)
    }

    convenience init(router: AppRouter, _questions: [Question], _index: Int) {
        self.init()
        self.router = router
        self.questions = _questions
        self.index = _index
        self.question = questions[index]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let newBackButton = UIBarButtonItem(title: "Back",
                style: UIBarButtonItem.Style.plain,
                target: self,
                action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        questionTextLabel = UILabel()
        questionTextLabel.numberOfLines = 3
        questionTextLabel.text = question.question
        questionTextLabel.textColor = .white
        questionTextLabel.textAlignment = .center
        questionTextLabel.font = UIFont.boldSystemFont(ofSize: 18.0)

        answerButtons = [UIButton]()
        for i in 0...3 {
            answerButtons.append(UIButton())

            answerButtons[i].addTarget(self, action: #selector(self.nextQuestion), for: .touchUpInside)
            answerButtons[i].setTitleColor(.black, for: .normal)
            answerButtons[i].setTitle(question.answers[i], for: .normal)
            answerButtons[i].backgroundColor = .white
            answerButtons[i].tintColor = .purple

            view.addSubview(answerButtons[i])
        }


        view.addSubview(questionTextLabel)

    }

    private func addConstraints() {
        questionTextLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.left.equalToSuperview()
        }

        for i in 0...3 {
            answerButtons[i].snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.7)
                make.top.equalToSuperview().offset(240 + 60 * i)
                make.centerX.equalToSuperview()
            }
            answerButtons[i].layer.cornerRadius = 20

        }


    }


}