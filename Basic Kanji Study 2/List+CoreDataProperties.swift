//
//  List+CoreDataProperties.swift
//  Basic Kanji Study 2
//
//  Created by Xavier Serra Soteras on 18/12/16.
//  Copyright © 2016 Limaraxa SL. All rights reserved.
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List");
    }

    @NSManaged public var creationDate: NSDate
    @NSManaged public var favoriteSelected: Bool
    @NSManaged public var id: Int32
    @NSManaged public var lastAccessDate: NSDate
    @NSManaged public var random: Bool
    @NSManaged public var type: String
    @NSManaged public var lastStudyOrderIdViewed: Int32
    @NSManaged public var lessons: Set<Lesson>?
    @NSManaged public var order: Set<StudyOrder>?

}

// MARK: Generated accessors for lessons
extension List {

    @objc(addLessonsObject:)
    @NSManaged public func addToLessons(_ value: Lesson)

    @objc(removeLessonsObject:)
    @NSManaged public func removeFromLessons(_ value: Lesson)

    @objc(addLessons:)
    @NSManaged public func addToLessons(_ values: NSSet)

    @objc(removeLessons:)
    @NSManaged public func removeFromLessons(_ values: NSSet)

}

// MARK: Generated accessors for order
extension List {

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: StudyOrder)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: StudyOrder)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSSet)

}
