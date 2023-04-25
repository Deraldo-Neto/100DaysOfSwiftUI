//
//  Location.swift
//  WhoIsWho
//
//  Created by Deraldo on 13/02/23.
//

import Foundation

import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), latitude: 0, longitude: 0)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
