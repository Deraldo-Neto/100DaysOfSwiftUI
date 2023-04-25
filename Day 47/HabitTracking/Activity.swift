//
//  Activity.swift
//  HabitTracking
//
//  Created by Deraldo on 30/08/22.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var completed: Int
}
