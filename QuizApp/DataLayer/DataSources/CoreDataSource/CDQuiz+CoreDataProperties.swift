//
//  CDQuiz+CoreDataProperties.swift
//  
//
//  Created by Matej Butkovic on 29.05.2021..
//
//

import Foundation
import CoreData


extension CDQuiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuiz> {
        return NSFetchRequest<CDQuiz>(entityName: "CDQuiz")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var title: String?
    @NSManaged public var quiz_description: String?
    @NSManaged public var level: Int32
    @NSManaged public var imageUrl: String?
    @NSManaged public var questions: CDQuesiton?
    @NSManaged public var category: CDQuizCategory?

}
