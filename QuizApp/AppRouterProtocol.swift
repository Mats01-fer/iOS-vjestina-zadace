//
//  AppRouterProtocol.swift
//  QuizApp
//
//  Created by Matej Butkovic on 07.05.2021..
//

import Foundation
import UIKit

protocol AppRouterProtocol {
 
    func setStartScreen(in window: UIWindow?)
}

class AppRouter: AppRouterProtocol {
    private var navigationConroller: UINavigationController!
    
    init(navigationConroller: UINavigationController){
        self.navigationConroller = navigationConroller
    }
    
    var window: UIWindow?
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router: self)
        
        navigationConroller.pushViewController(vc, animated: false)
        window?.rootViewController = navigationConroller
        window?.makeKeyAndVisible()
        
    }
    
    func showQuizzes(){
        let vc = QuizzesViewController(router: self)
        navigationConroller.setViewControllers([vc], animated: false) // replace root viewcontroller
        
    }
}
