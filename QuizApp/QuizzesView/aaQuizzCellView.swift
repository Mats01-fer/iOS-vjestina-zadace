//
//  QuizzCellView.swift
//  QuizApp
//
//  Created by Matej Butkovic on 12.04.2021..
//


import UIKit

class QuizzCellView: UITableViewCell {
    
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.red
        label.text = "ovo je teksr"
        return label
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.red
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
//        titleLabel.text = ""
    }
    
    func setup(withQuiz quiz: Quiz) {
        
        titleLabel.text = quiz.title
       
    }
    
    override func layoutSubviews() {
        
        contentView.addSubview(titleLabel)

    }
    
    
    
    
}
