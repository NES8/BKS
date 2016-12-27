//
//  StudyOrder+CoreDataProperties.swift
//  Basic Kanji Study 2
//
//  Created by Xavier Serra Soteras on 20/12/16.
//  Copyright © 2016 Limaraxa SL. All rights reserved.
//

import Foundation
import CoreData


extension StudyOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudyOrder> {
        return NSFetchRequest<StudyOrder>(entityName: "StudyOrder");
    }

    @NSManaged public var favorite: Bool
    @NSManaged public var id: Int32
    @NSManaged public var kanji: Kanji?
    @NSManaged public var list: List?
    @NSManaged public var vocabulary: Vocabulary?

}
