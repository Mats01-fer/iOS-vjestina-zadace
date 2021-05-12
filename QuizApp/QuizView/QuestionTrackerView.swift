//
// Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuestionTrackerView: UIView {

    private var progressLabel = UILabel()
    private var status: [UIColor]!
    private var bars: [UIView]!
    var correct: Int!
    var items: Int!

    convenience init(items: Int){
        self.init()
        self.items = items

        correct = 0

        status = [UIColor]()
        bars = [UIView]()
        for i in 0...items-1 {
            bars.append(UIView())
        }
        for bar in bars {
            bar.backgroundColor = .white
        }

    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // add constraints here
    }

    func updateProgress(index: Int, correct: Bool){
        if (correct){
            bars[index].backgroundColor = .green
            self.correct += 1
        } else{
            bars[index].backgroundColor = .red
        }

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // TODO: should use stackview
        // TODO: move this to init()

        let width = (self.bounds.width - 10) / CGFloat(items) // voodoo
        var n = CGFloat(0)
        for bar in bars{
            addSubview(bar)
            bar.snp.makeConstraints{ make in
                make.width.equalTo(width-10)
                make.height.equalTo(10)
                make.left.equalToSuperview().offset((n * width) + 10)
            }
            bar.layer.cornerRadius = 3
            bar.layer.masksToBounds = true

            n += 1

        }


    }
}