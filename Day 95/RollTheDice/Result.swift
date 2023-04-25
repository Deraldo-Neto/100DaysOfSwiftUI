//
//  Result.swift
//  RollTheDice
//
//  Created by Deraldo on 30/03/23.
//

import Foundation
import CoreLocation

struct Result: Identifiable, Codable {
    struct DicesValues: Identifiable, Codable {
        var id: UUID
        var value: Int
    }
    var id: UUID
    var date: Date
    var dicesValues: [DicesValues]
}
