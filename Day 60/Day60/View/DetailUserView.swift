//
//  DetailUserView.swift
//  Day60
//
//  Created by Deraldo on 11/10/22.
//

import SwiftUI

struct DetailUserView: View {
    var fetchRequest: FetchRequest<CachedUser>
    var user: CachedUser? { fetchRequest.wrappedValue.first }
    
    var body: some View {
        VStack {
            UserView(user: user!)
            Text("User View")
        }
    }
    
    init(userId: String) {
        fetchRequest = FetchRequest<CachedUser>(entity: CachedUser.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "id", userId))
    }
}
