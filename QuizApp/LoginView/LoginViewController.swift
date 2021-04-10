//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 10.04.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    var dataService = DataService()


    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var errorLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLable.isHidden = true
        emailField.attributedPlaceholder = NSAttributedString(string:"Email",
                                                              attributes:
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString(string:"password",
                                                              attributes:
                                                                [NSAttributedString.Key.foregroundColor: UIColor.white])

        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
