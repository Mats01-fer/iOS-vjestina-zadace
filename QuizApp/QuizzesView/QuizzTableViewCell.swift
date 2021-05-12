//
//  QuizzTableViewCell.swift
//  QuizApp
//
//  Created by Matej Butkovic on 12.04.2021..
//

import UIKit
import SnapKit

class QuizzTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var descriptionLabel = UILabel()
    var quizzImage = UIImageView()
    var difficultyOne = UIImageView(image: UIImage(systemName: "suit.diamond.fill"))
    var difficultyTwo = UIImageView(image: UIImage(systemName: "suit.diamond.fill"))
    var difficultyThree = UIImageView(image: UIImage(systemName: "suit.diamond.fill"))

    var accentColor: UIColor!
    var image: UIImage!

    init(frame: CGRect, title: String) {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cellId")

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code

        titleLabel = UILabel()

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(quizzImage)
        contentView.addSubview(difficultyOne)
        contentView.addSubview(difficultyTwo)
        contentView.addSubview(difficultyThree)

        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(18)
        descriptionLabel.textColor = .white
        descriptionLabel.font = descriptionLabel.font.withSize(12)


        difficultyOne.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        difficultyTwo.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        difficultyThree.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)

        self.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        quizzImage.layer.cornerRadius = 10
        quizzImage.clipsToBounds = true

        quizzImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.left.equalTo(contentView).offset(20)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(40)
            make.left.equalTo(contentView).offset(110)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(70)
            make.left.equalTo(contentView).offset(110)
        }

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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setup(withQuiz quizz: Quiz, withColor color: UIColor) {
        accentColor = color

        titleLabel.text = quizz.title
        descriptionLabel.text = quizz.description

        quizzImage.image = image

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
        // TODO: dont use contentView, wrap view in a background view
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}
