//
//  DataController.swift
//  Bookworm
//
//  Created by Deraldo on 27/09/22.
//

import CoreData
import Foundation

class DataController: ObservableObject { //responsável por pegar as infos do Core Data
    let container = NSPersistentContainer(name: "Bookworm") //Por favor, use o Bookworm (ele só prepara, não faz nada)
    
    init() { //Aqui ele carrega de fato
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
