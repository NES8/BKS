//
//  Vocabulary+CoreDataProperties.swift
//  Basic Kanji Study 2
//
//  Created by Xavier Serra Soteras on 20/12/16.
//  Copyright © 2016 Limaraxa SL. All rights reserved.
//

import Foundation
import CoreData


extension Vocabulary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vocabulary> {
        return NSFetchRequest<Vocabulary>(entityName: "Vocabulary");
    }

    @NSManaged public var id: Int32
    @NSManaged public var kanjis: NSObject?
    @NSManaged public var meaning: String?
    @NSManaged public var reading: String?
    @NSManaged public var word: String?
    @NSManaged public var kanji: Kanji?
    @NSManaged public var listOrders: NSSet?

}

// MARK: Generated accessors for listOrders
extension Vocabulary {

    @objc(addListOrdersObject:)
    @NSManaged public func addToListOrders(_ value: StudyOrder)

    @objc(removeListOrdersObject:)
    @NSManaged public func removeFromListOrders(_ value: StudyOrder)

    @objc(addListOrders:)
    @NSManaged public func addToListOrders(_ values: NSSet)

    @objc(removeListOrders:)
    @NSManaged public func removeFromListOrders(_ values: NSSet)

}
