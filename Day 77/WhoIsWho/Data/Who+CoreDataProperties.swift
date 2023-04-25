//
//  Who+CoreDataProperties.swift
//  WhoIsWho
//
//  Created by Deraldo on 14/02/23.
//
//

import Foundation
import CoreData


extension Who {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Who> {
        return NSFetchRequest<Who>(entityName: "Who")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var location: NSSet?
    
    public var locationArray: [CachedLocation] {
        let set = location as? Set<CachedLocation> ?? []
        
        return set.sorted {
            $0.id < $1.id
        }
    }
    
}

// MARK: Generated accessors for location
extension Who {

    @objc(addLocationObject:)
    @NSManaged public func addToLocation(_ value: CachedLocation)

    @objc(removeLocationObject:)
    @NSManaged public func removeFromLocation(_ value: CachedLocation)

    @objc(addLocation:)
    @NSManaged public func addToLocation(_ values: NSSet)

    @objc(removeLocation:)
    @NSManaged public func removeFromLocation(_ values: NSSet)

}

extension Who : Identifiable {

}
