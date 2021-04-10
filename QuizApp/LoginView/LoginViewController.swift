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
    
    var dataService = DataService()


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLable: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addConstraints()
        errorLable.isHidden = true
        emailField.attributedPlaceholder = NSAttributedString(string:"Email",
                                                              attributes:
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString(string:"password",
                                                              attributes:
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white])

    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        let response = dataService.login(email: email, password: password)
        switch response {
        case .success:
            print("Sucessful login")
            errorLable.isHidden = true
        default:
            print("Error while login")
            errorLable.isHidden = false

        }
        
        
        
    }
    
    private func addConstraints() {
        
        let elements = [titleLabel, emailField, passwordField, errorLable, loginButton]
        
        let height = view.bounds.height
        
        for element in elements{
            element!.snp.makeConstraints { make in
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
