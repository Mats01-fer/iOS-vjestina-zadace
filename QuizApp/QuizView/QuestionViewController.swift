//
// Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit
import SnapKit


class QuestionViewController: UIViewController {

    private var questionTextLabel: UILabel!

    private var questions: [Question]!
    private var quiz: Quiz!
    private var index: Int!
    private var question: Question!
    private var answerButtons: [UIButton]!
    private var noOfCorrect: Int!
    private var startTime: DispatchTime!

    private var progressBar: QuestionTrackerView!

    private var router: AppRouter!
    private var presenter: QuestionPresenter!

    @objc private func back(sender: UIButton) {
        router.showQuizzes()
    }

    @objc private func nextQuestion(_ sender: UIButton) {
        for btn in answerButtons {
            btn.isEnabled = false
        }
        var answerIndex = answerButtons.index(of: sender) ?? 0
        answerButtons[question.correctAnswer].backgroundColor = .green

        if (answerIndex != question.correctAnswer) {
            sender.backgroundColor = .red
        } else {
            noOfCorrect += 1
        }

        progressBar.updateProgress(index: self.index, correct: answerIndex == question.correctAnswer)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else {
                return
            }
            if (self.questions.count <= self.index + 1) {
                let endTime = DispatchTime.now()
                let nanoTime = endTime.uptimeNanoseconds - self.startTime.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000_000
                let defaults = UserDefaults.standard
                print("elapsed time: \(timeInterval), quiz id: \(self.quiz.id), user id: \(defaults.integer(forKey: "userId"))")
                self.presenter.postQuizResults(results: QuizResult(
                        quizId: self.quiz.id,
                        userId: defaults.integer(forKey: "userId"),
                        duration: timeInterval,
                        noOfCorrect: self.noOfCorrect))
                self.router.showResults(correct: self.noOfCorrect, total: self.questions.count)

            } else {
                self.setupQuestion(index: self.index + 1)
            }
        }
    }

    private func setupQuestion(index: Int) {
        self.index = index
        question = questions[index]
        questionTextLabel.text = question.question
        for i in 0...3 {
            answerButtons[i].setTitle(question.answers[i], for: .normal)
            answerButtons[i].backgroundColor = .white
            answerButtons[i].isEnabled = true

        }


    }

    convenience init(router: AppRouter, quiz: Quiz, _index: Int) {
        self.init()
        self.router = router
        self.questions = quiz.questions
        self.quiz = quiz
        self.index = _index
        self.question = questions[index]
        noOfCorrect = 0
        progressBar = QuestionTrackerView(items: questions.count)
        startTime = DispatchTime.now()
        presenter = QuestionPresenter()
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
        view.addSubview(progressBar)

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

        let width = view.bounds.width

        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(width - CGFloat(20))
            make.height.equalTo(10)
        }
    }


}
