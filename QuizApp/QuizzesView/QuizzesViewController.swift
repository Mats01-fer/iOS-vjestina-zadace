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
    
    private var getQuizzesButton: UIButton!
    
    private var quizzesTable: UITableView!
    
    private var funFactTitleLabel: UILabel!
    private var funFactLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
//        fetchQuizzes(UIButton())
        
       
       
        quizzesTable.register(UINib(nibName: "QuizzTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        quizzesTable.dataSource = self
        quizzesTable.delegate = self
        

    }
    private var nrOfCategories: Int = 0;
    private var nrPerSection: [Int] = [];
    private var quizzes: [[Quiz]] = [];
    private var categories: [QuizCategory] = [];
    
    @objc private func fetchQuizzes(_ sender: Any) {
        let allQuizzes = dataService.fetchQuizes()
        categories = Array(Set(allQuizzes.map({ $0.category })))
        
        for category in categories{
            quizzes.append(allQuizzes.filter({$0.category == category}))
        }
        
        
        //        let height = view.bounds.height
        //        var initalHeight = CGFloat(0.25)
        
        
        for quizz in categories{
                print(quizz)
        }
        
        var nrOFNBAQuestions = 0
        for q in allQuizzes{
            nrOFNBAQuestions += q.questions.filter({$0.question.contains("NBA")}).count
        }
        
        funFactLabel.text = "There are \(nrOFNBAQuestions) questions that contain the word “NBA”"
        funFactLabel.isHidden = false
        funFactTitleLabel.isHidden = false
        
        quizzesTable.reloadData()
        quizzesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
 

        
    }
    
    private func buildViews() {
        
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
    
//        quizesTable = UITableView(
//            frame: CGRect(
//                x: 0,
//                y: 200,
//                width: view.bounds.width,
//                height: view.bounds.height - 100))
        quizzesTable = UITableView()
        
        
        quizzesTable.backgroundView?.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        quizzesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        quizzesTable.separatorStyle = UITableViewCell.SeparatorStyle.none

        
        getQuizzesButton = UIButton()
        
        getQuizzesButton.setTitleColor(.black, for: .normal)
        getQuizzesButton.setTitle("Get Quizes", for: .normal)
        
        getQuizzesButton.backgroundColor = .white
        getQuizzesButton.tintColor = .black
        
        getQuizzesButton.addTarget(self, action:#selector(self.fetchQuizzes), for: .touchUpInside)
        
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
        
        view.addSubview(getQuizzesButton)
        view.addSubview(quizzesTable)
        view.addSubview(funFactLabel)
        view.addSubview(funFactTitleLabel)

        
//        quizesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        
        
        
    }
    
    private func addConstraints() {
        let height = view.bounds.height
        
        
        getQuizzesButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.1)
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
    
    
    
}





extension QuizzesViewController: UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: cellIdentifier,
//            for: indexPath)
//
//        cell.textLabel?.text = "\(quizzes[indexPath.section][indexPath.row].title)"
//
//        return cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! QuizzTableViewCell
        
        
           cell.setup(withQuiz: quizzes[indexPath.section][indexPath.row])
        
        return cell
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
        50.0
    }
}
