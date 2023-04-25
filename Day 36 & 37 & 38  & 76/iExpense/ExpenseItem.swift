//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Deraldo on 20/07/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable { //Isso significa que essa struct pode ser identificada unicamente, por que tem o UUID, com isso eu não preciso colocar um id: \.id nos foreachs, por exemplo, pq ele sabe que a struct possui um elemento que é único, o Codable é para permitir que a struct seja salva 
    var id = UUID() //Gera um UUID
    let name: String
    let type: String
    let amount: Double
}
