//
//  Result.swift
//  BucketList
//
//  Created by Deraldo on 30/11/22.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No further information" //Se existir o terms, e dentro dele existir uma chave chamada description, pega seu primeiro valor, se não, digita que não tem informações sobre
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
