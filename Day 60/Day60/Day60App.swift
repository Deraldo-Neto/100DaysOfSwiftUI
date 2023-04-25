//
//  Day60App.swift
//  Day60
//
//  Created by Deraldo on 10/10/22.
//

import SwiftUI

@main
struct Day60App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
