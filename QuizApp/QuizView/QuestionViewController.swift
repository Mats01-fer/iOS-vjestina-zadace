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

    private var router: AppRouter!

    convenience init(router: AppRouter, _questions: [Question], _index: Int) {
        self.init()
        self.router = router
        self.questions = _questions
        self.index = _index
        self.question = questions[index]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(question.question)

        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        questionTextLabel = UILabel()
        questionTextLabel.text = question.question
        questionTextLabel.textColor = .white
        questionTextLabel.textAlignment = .center
        questionTextLabel.font = UIFont.boldSystemFont(ofSize: 18.0)

        view.addSubview(questionTextLabel)

    }

    private func addConstraints() {
        questionTextLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.top.equalToSuperview().offset(140)
            make.left.equalToSuperview()
        }


    }


}