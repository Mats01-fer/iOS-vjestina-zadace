//
//  CDQuesiton+CoreDataProperties.swift
//  
//
//  Created by Matej Butkovic on 30.05.2021..
//
//

import Foundation
import CoreData


extension CDQuesiton {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuesiton> {
        return NSFetchRequest<CDQuesiton>(entityName: "CDQuesiton")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var question: String
    @NSManaged public var answers: NSObject
    @NSManaged public var correctAnswer: Int32
    @NSManaged public var quiz: CDQuiz?

}
