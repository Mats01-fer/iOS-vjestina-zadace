//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 11.04.2021..
//

import UIKit
import SnapKit


class QuizzesViewController: UIViewController {
    let dataService = DataService()
    let cellIdentifier = "cellId"

    private var titleLabel: UILabel!
    private var getQuizzesButton: UIButton!
    private var quizzesTable: UITableView!
    private var funFactTitleLabel: UILabel!
    private var funFactLabel: UILabel!
    private var sectionColors: [UIColor]!

    private var router: AppRouter!

    convenience init(router: AppRouter) {
        self.init()
        self.router = router
        self.title = "PopQuiz"

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PopQuiz"
        buildViews()
        addConstraints()

        quizzesTable.register(QuizzTableViewCell.self,
                forCellReuseIdentifier: cellIdentifier)
        quizzesTable.register(QuizzesTableSectionHeaderView.self,
                forHeaderFooterViewReuseIdentifier: "sectionHeader")
        quizzesTable.dataSource = self
        quizzesTable.delegate = self

        sectionColors = [
            UIColor(red: 0.34, green: 0.80, blue: 0.95, alpha: 1.00),
            UIColor(red: 0.95, green: 0.79, blue: 0.30, alpha: 1.00),
        ]


    }


    private func buildViews() {

        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        quizzesTable = UITableView()

        quizzesTable.backgroundView?.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        quizzesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        quizzesTable.separatorStyle = UITableViewCell.SeparatorStyle.none

        getQuizzesButton = UIButton()

        getQuizzesButton.setTitleColor(.black, for: .normal)
        getQuizzesButton.setTitle("Get Quizes", for: .normal)

        getQuizzesButton.backgroundColor = .white
        getQuizzesButton.tintColor = .black

        getQuizzesButton.addTarget(self, action: #selector(self.fetchQuizzes), for: .touchUpInside)

        funFactLabel = UILabel()
        funFactLabel.textColor = .white
        funFactLabel.contentMode = .scaleToFill
        funFactLabel.numberOfLines = 2
        funFactLabel.isHidden = true

        funFactTitleLabel = UILabel()
        funFactTitleLabel.text = "💡 Fun Fact"
        funFactTitleLabel.textColor = .white
        funFactTitleLabel.contentMode = .scaleToFill
        funFactTitleLabel.font = UIFont.systemFont(ofSize: 18)
        funFactTitleLabel.numberOfLines = 1
        funFactTitleLabel.isHidden = true

        titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.contentMode = .scaleToFill
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.numberOfLines = 1

        view.addSubview(getQuizzesButton)
        view.addSubview(quizzesTable)
        view.addSubview(funFactLabel)
        view.addSubview(funFactTitleLabel)
        view.addSubview(titleLabel)


    }

    private func addConstraints() {
        let height = view.bounds.height

        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.06)
        }

        getQuizzesButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.12)
        }
        getQuizzesButton.layer.cornerRadius = 20


        funFactTitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.88)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.2)
        }
        funFactLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.2 + 30.0)
        }

        quizzesTable.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.top.equalTo(view).offset(height * 0.3)
        }
    }

    private var nrOfCategories: Int = 0;
    private var nrPerSection: [Int] = [];
    private var quizzes: [[Quiz]] = [];
    private var categories: [QuizCategory] = [];

    @objc private func fetchQuizzes(_ sender: Any) {
        let allQuizzes = dataService.fetchQuizes()
        let allCategories = allQuizzes.map({ $0.category })
        for category in allCategories {
            if (!categories.contains(category)){
                categories.append(category)
            }
        }
        for category in categories {
            quizzes.append(allQuizzes.filter({ $0.category == category }))
        }

        var nrOFNBAQuestions = 0
        nrOFNBAQuestions = allQuizzes.flatMap {
                    $0.questions
                }
                .filter {
                    $0.question.contains("NBA")
                }
                .count


        funFactLabel.text = "There are \(nrOFNBAQuestions) questions that contain the word “NBA”"
        funFactLabel.isHidden = false
        funFactTitleLabel.isHidden = false

        quizzesTable.reloadData()
        quizzesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

    }
}

extension QuizzesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIdentifier,
                for: indexPath) as! QuizzTableViewCell
        cell.image = UIImage(named: "questionmark")
        let colorIndex = indexPath.section % sectionColors.count
        cell.setup(withQuiz: quizzes[indexPath.section][indexPath.row], withColor: sectionColors[colorIndex])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showQuiz(quiz: quizzes[indexPath.section][indexPath.row])
    }

    func tableView(
            _ tableView: UITableView,
            titleForHeaderInSection section: Int
    ) -> String? {
        return categories[section].rawValue
    }

}


extension QuizzesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        100.0
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
        "sectionHeader") as! QuizzesTableSectionHeaderView
        view.titleLabel.text = categories[section].rawValue

        return view
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let view = view as? UITableViewHeaderFooterView {
            let colorIndex = section % sectionColors.count
            view.textLabel?.backgroundColor = UIColor.clear
            view.textLabel?.textColor = sectionColors[colorIndex]

        }
    }
}
