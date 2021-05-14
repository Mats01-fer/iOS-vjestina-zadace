struct Quiz: Codable {

    let id: Int
    let title: String
    let description: String
    let category: QuizCategory
    let level: Int
    let imageUrl: String
    let questions: [Question]


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case category = "category"
        case level = "level"
        case imageUrl = "image"
        case questions = "questions"
    }

}
