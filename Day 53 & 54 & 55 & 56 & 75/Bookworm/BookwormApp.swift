//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Deraldo on 27/09/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) //Injetando as informações da data no ContentView
        }
    }
}
