//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 30.05.2021..
//

import UIKit

class SearchViewController: UIViewController {
    
    
    let cellIdentifier = "cellId"
    
    private var titleLabel: UILabel!
    var quizzesTable: UITableView!
    var searchField: UITextField!
    var searchButton: UIButton!
    private var sectionColors: [UIColor]!
    
    
    private var presenter: SearchPresenter?
    
    convenience init(presenter: SearchPresenter) {
        self.init()
        self.title = "PopQuiz"
        self.presenter = presenter
        self.presenter?.setView(view: self)
        
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
    
    @objc func search(_ sender: Any){
        presenter?.fetchQuizzes(name: searchField.text ?? "")
    }
    
    
    private func buildViews() {
        
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        
        searchField = UITextField()
        searchField.attributedPlaceholder = NSAttributedString(string: "Search",
                                                               attributes:
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        searchButton = UIButton()
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.setTitle("Search", for: .normal)

        
        searchButton.tintColor = .white

        searchButton.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        
        quizzesTable = UITableView()
        
        quizzesTable.backgroundView?.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        quizzesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        quizzesTable.separatorStyle = UITableViewCell.SeparatorStyle.none
    
        
        
        titleLabel = UILabel()
        titleLabel.text = "PopQuiz"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.contentMode = .scaleToFill
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.numberOfLines = 1
        
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(quizzesTable)
        view.addSubview(titleLabel)
        
        
    }
    
    private func addConstraints() {
        let height = view.bounds.height
        
        searchField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.12)
        }
        
        searchButton.snp.makeConstraints { make in
                make.width.equalToSuperview().multipliedBy(0.2)
                make.height.equalTo(45)
                make.right.equalToSuperview()
                make.top.equalTo(view).offset(height * 0.12)
            }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalTo(view).offset(height * 0.06)
        }
        
        
        
        quizzesTable.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.top.equalTo(view).offset(height * 0.2)
        }
    }
    
    private var nrOfCategories: Int = 0;
    private var nrPerSection: [Int] = [];
    internal var quizzes: [[Quiz]] = [];
    var categories: [QuizCategory] = [];
    
}

extension SearchViewController: UITableViewDataSource {
    
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
        presenter?.showQuiz(quiz: quizzes[indexPath.section][indexPath.row])
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return categories[section].rawValue
    }
    
}


extension SearchViewController: UITableViewDelegate {
    
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

extension SearchViewController: SearchPresnterDelegate{
    func showQuizzes(allQuizzes: [Quiz]) {
        let allCategories = allQuizzes.map({ $0.category })
        for category in allCategories {
            if (!categories.contains(category)){
                categories.append(category)
            }
        }
        for category in categories {
            quizzes.append(allQuizzes.filter({ $0.category == category }))
        }
        
        quizzesTable.reloadData()
        quizzesTable.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        
    }
}
