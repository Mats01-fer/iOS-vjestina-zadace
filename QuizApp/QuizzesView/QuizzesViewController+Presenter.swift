//
// Created by Matej Butkovic on 14.05.2021..
//

import Foundation
import UIKit

extension QuizzesViewController: QuizzesPresenterProtocol {
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
