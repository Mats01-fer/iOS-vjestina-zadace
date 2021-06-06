//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 10.04.2021..
//

import UIKit
import PureLayout
import SnapKit


class LoginViewController: UIViewController {
    
    //    var dataService = DataService()
    private var presenter: LoginPresenter!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLable: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    convenience init(presenter: LoginPresenter) {
        self.init()
        self.presenter = presenter
        self.presenter.setDelegate(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PopQuiz"
        
        addConstraints()
        errorLable.isHidden = true
        emailField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                              attributes:
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                 attributes:
                                                                    [NSAttributedString.Key.foregroundColor: UIColor.white])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleLabel.transform = titleLabel.transform.scaledBy(x: 0, y: 0)
        titleLabel.alpha = 0
        
        let width = view.bounds.width
        let elements = [emailField, passwordField, loginButton]
        for element in elements {
            element?.alpha = 0
            element?.transform = element!.transform.translatedBy(x: -width, y: 0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: { [self] in
                        titleLabel.alpha = 1
                        titleLabel.transform = .identity
                        self.view.layoutIfNeeded()
                       })
        
        let elements = [emailField, passwordField, loginButton]
        var delay = 0.0
        for element in elements {
            UIView.animate(withDuration: 1.5,
                           delay: delay,
                           options: [.curveEaseInOut],
                           animations: { [self] in
                            element!.alpha = 1
                            element!.transform = .identity
                            self.view.layoutIfNeeded()
                           })
            delay += 0.25
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        loginButton.isEnabled = false
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        presenter.login(email: email, password: password)
    }
    
    private func addConstraints() {
        
        let elements = [titleLabel, emailField, passwordField, errorLable, loginButton]
        let height = view.bounds.height
        for element in elements {
            element!.snp.makeConstraints { make in
                // should gard this instead of force unwrapping
                make.width.equalToSuperview().multipliedBy(0.8)
                make.height.equalTo(45)
                make.centerX.equalToSuperview()
            }
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(height * 0.1)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(view).offset(height * 0.2)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField).offset(45 + 18)
        }
        
        errorLable.snp.makeConstraints { make in
            make.top.equalTo(passwordField).offset(38)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(errorLable).offset(38)
        }
        loginButton.layer.cornerRadius = 20
        
    }
    
}

extension LoginViewController: LoginPresenterDelegate {
    func loginSuccess() {
        loginButton.isEnabled = true
        print("Sucessful login")
        errorLable.isHidden = true
        animatedRemove()
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.presenter.showQuizzes()
        }
        
    }
    
    func loginFail() {
        loginButton.isEnabled = true
        print("Error while login")
        errorLable.isHidden = false
        
    }
    
    func animatedRemove() {
        let height = view.bounds.height
        let elements = [titleLabel, emailField, passwordField, loginButton ]
        var delay = 0.0
        for element in elements {
            UIView.animate(withDuration: 1.5,
                           delay: delay,
                           options: [.curveEaseInOut],
                           animations: { [self] in
                            element!.alpha = 1
                            element!.transform = element!.transform.translatedBy(x: 0, y: -height)
                            self.view.layoutIfNeeded()
                           })
            delay += 0.25
        }
        
    }
}
