//
// Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit
import SnapKit

class QuizResultViewController: UIViewController {

    private var resultLabel: UILabel!
    private var finishQuizButton: UIButton!

    private var progress: QuestionTrackerView!

    private var router: AppRouter!

    @objc private func back(sender: UIButton) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        router.showQuizzes()
    }

    convenience init(router: AppRouter, progress: QuestionTrackerView){
        self.init()
        self.progress = progress
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        let newBackButton = UIBarButtonItem(title: "Back",
                style: UIBarButtonItem.Style.plain,
                target: self,
                action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton

        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        resultLabel = UILabel()
        resultLabel.text = String(progress.correct) + "/" + String(progress.items)
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 40.0)

        finishQuizButton = UIButton()
        finishQuizButton.addTarget(self, action: #selector(self.back(sender:)), for: .touchUpInside)
        finishQuizButton.setTitleColor(.black, for: .normal)
        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        finishQuizButton.backgroundColor = .white
        finishQuizButton.tintColor = .purple


        view.addSubview(resultLabel)
        view.addSubview(finishQuizButton)
    }

    private func addConstraints() {
        resultLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        finishQuizButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        finishQuizButton.layer.cornerRadius = 20

    }
}