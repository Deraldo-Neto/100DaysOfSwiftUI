//
//  User.swift
//  Day60
//
//  Created by Deraldo on 10/10/22.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    var formatedDataRegistered: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
}

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}

extension User {
    static let userTest = User(id: UUID(), isActive: true, name: "Deraldo", age: 27, company: "iOS Tech", email: "deraldoalmeidaneto@gmail.com", address: "Rua dos Bobos, Nº 69, Uberlândia - MG.", about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean molestie, sapien et feugiat mattis, ex magna dictum eros, vel gravida risus orci in urna. In non nunc ac odio pellentesque porttitor et ac tellus. Nullam condimentum, risus non lacinia feugiat, nulla nunc dignissim odio, vitae congue lectus tortor a metus.", registered: Date.now, tags: ["Tag 1", "Tag 2"], friends: [Friend(id: UUID(), name: "Teste")])
    
    static let friendTest = [User(id: UUID(), isActive: true, name: "Alves", age: 27, company: "iOS Tech", email: "deraldoalmeidaneto@gmail.com", address: "Rua dos Bobos, Nº 69, Uberlândia - MG.", about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean molestie, sapien et feugiat mattis, ex magna dictum eros, vel gravida risus orci in urna. In non nunc ac odio pellentesque porttitor et ac tellus. Nullam condimentum, risus non lacinia feugiat, nulla nunc dignissim odio, vitae congue lectus tortor a metus.", registered: Date.now, tags: ["Tag 1", "Tag 2"], friends: [Friend(id: UUID(), name: "Teste")]), User(id: UUID(), isActive: true, name: "Almeida", age: 27, company: "iOS Tech", email: "deraldoalmeidaneto@gmail.com", address: "Rua dos Bobos, Nº 69, Uberlândia - MG.", about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean molestie, sapien et feugiat mattis, ex magna dictum eros, vel gravida risus orci in urna. In non nunc ac odio pellentesque porttitor et ac tellus. Nullam condimentum, risus non lacinia feugiat, nulla nunc dignissim odio, vitae congue lectus tortor a metus.", registered: Date.now, tags: ["Tag 1", "Tag 2"], friends: [Friend(id: UUID(), name: "Teste")])]
}

