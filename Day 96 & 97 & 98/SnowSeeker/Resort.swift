//
//  Resort.swift
//  SnowSeeker
//
//  Created by Deraldo on 11/04/23.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json") //Aqui é static por que ele não é criado até ser usado
    static let example = allResorts[0] //E por os dois estarem estáticos, ele cria na ordem, não correndo risco de dar pau
    
    //static let example = (Bundle.main.decode("resorts.json") as [Resort])[0] //É igual ao de cima, cria um exemplo de Resorts, que é basicamente, o json
}
