//
//  DataController.swift
//  Bookworm
//
//  Created by Deraldo on 27/09/22.
//

import CoreData
import Foundation

class DataController: ObservableObject { //responsável por pegar as infos do Core Data
    let container = NSPersistentContainer(name: "") //Por favor, use o Bookworm (ele só prepara, não faz nada)
    
    init() { //Aqui ele carrega de fato
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // Com isso aqui, ele da merge nos objetos e salva só um. Não só isso, caso eu coloque algo como constraint, caso vc coloque nomes repetidos, ele não vai aceitar, vai deixar único, por exemplo no caso de vc criar um monte de cidade chamado uberlandia, na real ele vai criar somente uma e dar merge nas outras nessa
        }
    }
}
