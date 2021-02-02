//
//  CD_Friend+CoreDataProperties.swift
//  UsersChallenge
//
//  Created by Marko Kramar on 13/10/2020.
//
//

import Foundation
import CoreData


extension CD_Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_Friend> {
        return NSFetchRequest<CD_Friend>(entityName: "CD_Friend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

}

extension CD_Friend : Identifiable {

}
