//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Matej Butkovic on 30.05.2021..
//

import Foundation
import CoreData


extension Quiz {
    init(with entity: CDQuiz){
        id = Int(entity.identifier)
        title = entity.title
        description = entity.quiz_description
        level = Int(entity.level)
        imageUrl = ""
        category = .sport
        questions = []
        self.makeQuestionsArray(cdQuestions: entity.questions!)
        
    }
    
    mutating func makeQuestionsArray(cdQuestions: NSSet) {
        for cdQuestion in cdQuestions.allObjects {
            print(cdQuestion)
        }
        self.questions = [Question(id: 1, question: "a question", answers: ["a", "b", "c", "d"], correctAnswer: 0)]
    }
    
    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.identifier = Int32(id)
        entity.imageUrl = ""
        entity.title = title
        entity.quiz_description = description
        entity.level = Int32(level)
    }
    
}
