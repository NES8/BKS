//
//  Kanji+CoreDataProperties.swift
//  Basic Kanji Study 2
//
//  Created by Xavier Serra Soteras on 20/12/16.
//  Copyright © 2016 Limaraxa SL. All rights reserved.
//

import Foundation
import CoreData


extension Kanji {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kanji> {
        return NSFetchRequest<Kanji>(entityName: "Kanji");
    }

    @NSManaged public var id: Int32
    @NSManaged public var kanji: String?
    @NSManaged public var kunyomi: String?
    @NSManaged public var meaning: String?
    @NSManaged public var onyomi: String?
    @NSManaged public var strokes: Int16
    @NSManaged public var lesson: Lesson?
    @NSManaged public var listOrders: NSSet?
    @NSManaged public var vocabularies: NSSet?

}

// MARK: Generated accessors for listOrders
extension Kanji {

    @objc(addListOrdersObject:)
    @NSManaged public func addToListOrders(_ value: StudyOrder)

    @objc(removeListOrdersObject:)
    @NSManaged public func removeFromListOrders(_ value: StudyOrder)

    @objc(addListOrders:)
    @NSManaged public func addToListOrders(_ values: NSSet)

    @objc(removeListOrders:)
    @NSManaged public func removeFromListOrders(_ values: NSSet)

}

// MARK: Generated accessors for vocabularies
extension Kanji {

    @objc(addVocabulariesObject:)
    @NSManaged public func addToVocabularies(_ value: Vocabulary)

    @objc(removeVocabulariesObject:)
    @NSManaged public func removeFromVocabularies(_ value: Vocabulary)

    @objc(addVocabularies:)
    @NSManaged public func addToVocabularies(_ values: NSSet)

    @objc(removeVocabularies:)
    @NSManaged public func removeFromVocabularies(_ values: NSSet)

}
