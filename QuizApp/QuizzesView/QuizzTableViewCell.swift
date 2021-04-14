//
//  QuizzTableViewCell.swift
//  QuizApp
//
//  Created by Matej Butkovic on 12.04.2021..
//

import UIKit
import SnapKit

class QuizzTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var quizzImage: UIImageView!
    
    
    @IBOutlet weak var difficultyOne: UIImageView!
    
    @IBOutlet weak var difficultyTwo: UIImageView!
    
    @IBOutlet weak var difficultyThree: UIImageView!
    
    var accentColor: UIColor!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor =  UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        quizzImage.layer.cornerRadius = 10
        
        
        difficultyThree.snp.makeConstraints { make in
            
            make.top.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-20)
        }
        difficultyTwo.snp.makeConstraints { make in
            
            make.top.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-40)
        }
        difficultyOne.snp.makeConstraints { make in
            
            make.top.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-60)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
    }
    
    func setup(withQuiz quizz: Quiz, withColor color: UIColor) {
        accentColor = color
        
        titleLabel.text = quizz.title
        descriptionLabel.text = quizz.description
        //        difficultyLabel.text = String(quizz.level)
        
        switch quizz.level {
        case 3:
            difficultyThree.tintColor = color
            fallthrough
        case 2:
            difficultyTwo.tintColor = color
            fallthrough
        default:
            difficultyOne.tintColor = color
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
        
    }
    
}
