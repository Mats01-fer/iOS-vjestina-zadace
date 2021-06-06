//
//  CDQuiz+CoreDataProperties.swift
//  
//
//  Created by Matej Butkovic on 30.05.2021..
//
//

import Foundation
import CoreData


extension CDQuiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuiz> {
        return NSFetchRequest<CDQuiz>(entityName: "CDQuiz")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var title: String
    @NSManaged public var quiz_description: String
    @NSManaged public var level: Int32
    @NSManaged public var imageUrl: String?
    @NSManaged public var cetegory: String
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension CDQuiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: CDQuesiton)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: CDQuesiton)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}
