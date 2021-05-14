//
// Created by Matej Butkovic on 14.05.2021..
//

struct QuizResult: Codable {

    let quizId: Int
    let userId: Int
    let duration: Double
    let noOfCorrect: Int

    enum CodingKeys: String, CodingKey {
        case quizId = "quiz_id"
        case userId = "user_id"
        case duration = "time"
        case noOfCorrect = "no_of_correct"
    }
}