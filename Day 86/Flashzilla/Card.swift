//
//  Card.swift
//  Flashzilla
//
//  Created by Deraldo on 09/03/23.
//

import Foundation


struct Card: Codable {
    let id: UUID
    let prompt: String
    let answer: String
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor who?", answer: "Jodie Whittaker")
}
