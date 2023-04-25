    //
//  WhoIsWhoApp.swift
//  WhoIsWho
//
//  Created by Deraldo on 10/01/23.
//

import SwiftUI

@main
struct WhoIsWhoApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
