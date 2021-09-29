//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//
//

import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var modificationDate: Date?
    @NSManaged public var text: String?

}

extension Note: Identifiable {

}
