//
//  QuizzTableViewCell.swift
//  QuizApp
//
//  Created by Matej Butkovic on 12.04.2021..
//

import UIKit

class QuizzTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        self.backgroundColor =  UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        contentView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
    }
    
    func setup(withQuiz quiz: Quiz) {
        
        titleLabel.text = quiz.title
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
}
