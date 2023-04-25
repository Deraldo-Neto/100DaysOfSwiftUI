//
//  CachedLocation+CoreDataProperties.swift
//  WhoIsWho
//
//  Created by Deraldo on 14/02/23.
//
//

import Foundation
import CoreData


extension CachedLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedLocation> {
        return NSFetchRequest<CachedLocation>(entityName: "CachedLocation")
    }

    @NSManaged public var id: UUID
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var who: Who

}

extension CachedLocation : Identifiable {

}
