//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 10.04.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    var dataService = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        let response = dataService.login(email: email, password: password)
        switch response {
        case .success:
            print("Sucessful login")
        default:
            print("Error while login")

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
