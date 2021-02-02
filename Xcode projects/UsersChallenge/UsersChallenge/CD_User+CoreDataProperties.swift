//
//  CD_User+CoreDataProperties.swift
//  UsersChallenge
//
//  Created by Marko Kramar on 13/10/2020.
//
//

import Foundation
import CoreData


extension CD_User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD_User> {
        return NSFetchRequest<CD_User>(entityName: "CD_User")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var reigstered: Date?
    @NSManaged public var tags: NSArray?
    @NSManaged public var friends: NSSet?
    
    var tagsArray: [String] {
        get {
            return tags as? Array<String> ?? []
        }
        set {
            tags = newValue as NSArray
        }
    }
    
    public var friendsArray: [CD_Friend] {
        let set = friends as? Set<CD_Friend> ?? []
        return set.sorted {
            $0.name! < $1.name!
        }
    }

}

// MARK: Generated accessors for friends
extension CD_User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CD_Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CD_Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CD_User : Identifiable {

}
