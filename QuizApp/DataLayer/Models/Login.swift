//
//  Login.swift
//  QuizApp
//
//  Created by Matej Butkovic on 14.05.2021..
//

import Foundation

struct Login: Codable {

    let token: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case userId = "user_id"
    }
}
