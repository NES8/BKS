//
//  Lesson+CoreDataProperties.swift
//  Basic Kanji Study 2
//
//  Created by Xavier Serra Soteras on 18/12/16.
//  Copyright © 2016 Limaraxa SL. All rights reserved.
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson");
    }

    @NSManaged public var id: Int32
    @NSManaged public var course: Int16
    @NSManaged public var kanjis: Set<Kanji>?
    @NSManaged public var list: Set<List>?

}

// MARK: Generated accessors for kanjis
extension Lesson {

    @objc(addKanjisObject:)
    @NSManaged public func addToKanjis(_ value: Kanji)

    @objc(removeKanjisObject:)
    @NSManaged public func removeFromKanjis(_ value: Kanji)

    @objc(addKanjis:)
    @NSManaged public func addToKanjis(_ values: NSSet)

    @objc(removeKanjis:)
    @NSManaged public func removeFromKanjis(_ values: NSSet)

}

// MARK: Generated accessors for list
extension Lesson {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: List)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: List)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}
