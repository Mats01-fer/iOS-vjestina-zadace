//
// Created by Matej Butkovic on 27.05.2021..
//

import Foundation
import UIKit

protocol LoginPresenterDelegate: AnyObject {
    func loginSuccess()
    func loginFail()
}