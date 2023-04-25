//
//  FileManager-DocumentsDirectory.swift
//  WhoIsWho
//
//  Created by Deraldo on 12/01/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
