//
//  QuizzesTableSectionHeaderView.swift
//  QuizApp
//
//  Created by Matej Butkovic on 13.04.2021..
//

import UIKit

class QuizzesTableSectionHeaderView: UITableViewHeaderFooterView {

    var titleLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }

    func configureContents() {

        tintColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        titleLabel = UILabel()
        titleLabel.textColor = .white
        textLabel?.backgroundColor = .clear
        contentView.tintColor = .white

        self.addSubview(titleLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
