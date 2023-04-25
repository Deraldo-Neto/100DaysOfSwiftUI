//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Deraldo on 02/12/22.
//

import Foundation

extension FileManager { //Colocamos essa extenmsão para o FileManager para com que facilite o acesso em qualquer projeto
    static var documentsDirectory: URL { //Podemos criar uma URL para um arquivo nos nossos documentos seja lá de onde ele estiver
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
