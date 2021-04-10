//
//  ViewController.swift
//  QuizApp
//
//  Created by Matej Butkovic on 10.04.2021..
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    @IBAction func logInAction(_ sender: UIButton) {
        print("\(sender.currentTitle!) button tap!")
        print("username: \(usernameField.text)")
        print("password: \(passwordField.text)")

        usernameField.text = ""
        passwordField.text = ""
    }
}

