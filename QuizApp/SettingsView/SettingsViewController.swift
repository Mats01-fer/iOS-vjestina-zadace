//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    private var usernameLabel: UILabel!
    private var nameLabel: UILabel!
    private var logOutButton: UIButton!

    private var router: AppRouter!

    @objc private func logOut(_ sender: Any) {
        router.backToLogin()
    }

    convenience init(router: AppRouter) {
        self.init()
        self.router = router
        self.title = "Settings"

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"

        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)

        usernameLabel = UILabel()
        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 12.0)

        nameLabel = UILabel()
        nameLabel.text = "Matej Butković"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)

        logOutButton = UIButton()
        logOutButton.addTarget(self, action: #selector(self.logOut), for: .touchUpInside)
        logOutButton.setTitleColor(.purple, for: .normal)
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.backgroundColor = .white
        logOutButton.tintColor = .purple

        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(logOutButton)
    }

    private func addConstraints() {

        usernameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(view.bounds.height * 0.15)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset((view.bounds.height * 0.15) + 50)
        }
        logOutButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-view.bounds.height * 0.2)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(45)
        }
        logOutButton.layer.cornerRadius = 20


    }
}