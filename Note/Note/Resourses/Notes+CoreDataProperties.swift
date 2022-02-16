//
//  Notes+CoreDataProperties.swift
//  Note
//
//  Created by Татьяна Лузанова on 16.02.2022.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var textStyle: String?

}

extension Notes : Identifiable {

}
