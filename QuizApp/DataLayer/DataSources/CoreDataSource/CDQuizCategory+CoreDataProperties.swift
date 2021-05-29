//
//  CDQuizCategory+CoreDataProperties.swift
//  
//
//  Created by Matej Butkovic on 29.05.2021..
//
//

import Foundation
import CoreData


extension CDQuizCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuizCategory> {
        return NSFetchRequest<CDQuizCategory>(entityName: "CDQuizCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var quiz: NSSet?

}

// MARK: Generated accessors for quiz
extension CDQuizCategory {

    @objc(addQuizObject:)
    @NSManaged public func addToQuiz(_ value: CDQuiz)

    @objc(removeQuizObject:)
    @NSManaged public func removeFromQuiz(_ value: CDQuiz)

    @objc(addQuiz:)
    @NSManaged public func addToQuiz(_ values: NSSet)

    @objc(removeQuiz:)
    @NSManaged public func removeFromQuiz(_ values: NSSet)

}
