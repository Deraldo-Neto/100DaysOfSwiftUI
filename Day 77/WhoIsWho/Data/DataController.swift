//
//  DataController.swift
//  WhoIsWho
//
//  Created by Deraldo on 12/01/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "WhoIsWho")
    
    init() { //Aqui ele carrega de fato
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
