//
//  QuizzTableViewCell.swift
//  QuizApp
//
//  Created by Matej Butkovic on 12.04.2021..
//

import UIKit

class QuizzTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var quizzImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor =  UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        quizzImage.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
    }
    
    func setup(withQuiz quiz: Quiz) {
        
        titleLabel.text = quiz.title
        descriptionLabel.text = quiz.description
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
    }
    
}
