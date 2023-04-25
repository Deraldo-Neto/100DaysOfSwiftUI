//
//  Astronaut.swift
//  Moonshot
//
//  Created by Deraldo on 26/07/22.
//

import Foundation

struct Astronaut: Codable, Identifiable { //Um Codable, é um decodable e um encodable
    let id: String
    let name: String
    let description: String
}
