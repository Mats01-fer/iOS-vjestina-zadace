//
// Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit

class QuestionTrackerView: UIStackView {

    private var status: [UIColor]!
    private var bars: [UIView]!
    var correct: Int!
    var items: Int!

    convenience init(items: Int) {
        self.init()
        self.items = items
        correct = 0

        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false


        status = [UIColor]()
        bars = [UIView]()
        for _ in 0...items - 1 {
            let bar = UIView()
            bars.append(bar)
            bar.backgroundColor = .white
            bar.layer.cornerRadius = 3
            bar.layer.masksToBounds = true
            addArrangedSubview(bar)
        }

    }

    func updateProgress(index: Int, correct: Bool) {
        if (correct) {
            bars[index].backgroundColor = .green
            self.correct += 1
        } else {
            bars[index].backgroundColor = .red
        }

    }

}
