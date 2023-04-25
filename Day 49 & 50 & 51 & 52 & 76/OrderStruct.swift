//
//  Order.swift
//  CupcakeCorner
//
//  Created by Deraldo on 15/09/22.
//

import SwiftUI
import Foundation

class Order: ObservableObject {
    @Published var orderStruct = OrderStruct()
}

struct OrderStruct: Codable { //Essa classe é observada por todo o meu código, por isso as propriedades dela são todas Published, Não pode ser Codable por conta dos Publisheds, lembrando que o codable é o encodable e o decodable juntos
    enum CodingKeys: CodingKey { //Crio o enum para poder fazer a classe ser Codable
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet { //Se o valor mudar, eu jogo tudo pra falso
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    init() {} //Com isso eu consigo compilar de novo, por que as vezes a gente quer apenas criar um Order vazio.
    
}
