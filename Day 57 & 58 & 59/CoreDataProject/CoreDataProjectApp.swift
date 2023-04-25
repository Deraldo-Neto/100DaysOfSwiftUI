//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Deraldo on 29/09/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) //Injetando as informações da data no ContentView
        }
    }
}
