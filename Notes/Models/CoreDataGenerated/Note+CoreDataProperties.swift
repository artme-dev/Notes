//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Артём on 03.10.2021.
//
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var modificationDate: Date?
    @NSManaged public var text: NSAttributedString?
    @NSManaged public var title: String?

}
