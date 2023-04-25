//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Deraldo on 26/07/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T { //recebe uma string e retorna um T, que pode ser QUALQUER COISA, O T serve para deixar genérico, pode ser QUALQUER NOME, T é uam convensão, de Type, pode ser qualquer tipo. T: Codable tá dizendo para ele que ele é Codable, com isso some o erro do .decode
        guard let url = self.url(forResource: file, withExtension: nil) else { //caso encontre o arquivo armazena na variável
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else { //tenta abrir a DATA (não string, como antes)
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder() //cria um decoder
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd" //Conversão da data que a gente tem no nosso .json
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else { //tenta decodificar o json em um dicionário
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
