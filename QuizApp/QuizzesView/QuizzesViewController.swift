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
    
    private var quizesTable: UITableView!
    
    private var funFactLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        addConstraints()
//        fetchQuizzes(UIButton())
        
       
        quizesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        quizesTable.dataSource = self
        

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
        
        quizesTable.reloadData()
        
    }
    
    private func buildViews() {
        
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
    
//        quizesTable = UITableView(
//            frame: CGRect(
//                x: 0,
//                y: 200,
//                width: view.bounds.width,
//                height: view.bounds.height - 100))
        quizesTable = UITableView()
        view.addSubview(quizesTable)
        
        
        getQuizzesButton = UIButton()
        
        getQuizzesButton.setTitleColor(.black, for: .normal)
        getQuizzesButton.setTitle("Get Quizes", for: .normal)
        
        getQuizzesButton.backgroundColor = .white
        getQuizzesButton.tintColor = .black
        
        getQuizzesButton.addTarget(self, action:#selector(self.fetchQuizzes), for: .touchUpInside)
        
        
        view.addSubview(getQuizzesButton)
        
        
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
        
        quizesTable.snp.makeConstraints { make in
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath)
        
        cell.textLabel?.text = "\(quizzes[indexPath.section][indexPath.row].title)"
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return categories[section].rawValue
    }

    
    
}
