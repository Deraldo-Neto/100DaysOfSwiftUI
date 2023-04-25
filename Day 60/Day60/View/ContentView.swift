//
//  ContentView.swift
//  Day60
//
//  Created by Deraldo on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink {
                    DetailUserView(userId: user.id!.uuidString)
                } label: {
                    HStack {
                        Text("\(user.checkIsActive)")
                        Text(user.wrappedName)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(user.wrappedCompany)
                            .font(.caption)
                            .foregroundColor(.black.opacity(0.5))
                    }
                }
                .listStyle(.plain)
            }
            .task {
                if users.isEmpty {
                    print("Users is empty!")
                    print("Getting data...")
                    let usersJson = await Users.LoadDataFromJson()
                    print("Saving data...")
                    await Users.SaveDataToDB(users: usersJson, moc: moc)
                }
            }
            .navigationTitle("User List")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
