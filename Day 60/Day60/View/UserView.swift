//
//  UserView.swift
//  Day60
//
//  Created by Deraldo on 27/10/22.
//

import SwiftUI

struct UserView: View {
    
    var user: CachedUser
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("\(user.wrappedName), \(user.age)")
                        .font(.title.bold())
                        .padding(.bottom, 1)
                    Text("\(user.wrappedEmail)")
                        .font(.subheadline)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                        .padding(.vertical)
                    
                    Text("About:")
                        .font(.title2.bold())
                        .padding(.bottom, 2)
                    Text("\(user.wrappedAbout)")
                        .padding(.bottom, 1)
                    Text("Registered: \(user.wrappedRegistered).")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.subheadline)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.3))
                        .padding(.vertical)
                    
                    Text("Friend(s):")
                        .font(.title2.bold())
                        .padding(.bottom, 2)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.friendArray) { friend in
                                HStack {
                                    VStack(alignment: .leading) {
                                        NavigationLink(destination: DetailUserView(userId: friend.wrappedId.uuidString)) {
                                            Text(friend.wrappedName)
                                                .font(.headline)
                                                .clipShape(Capsule())
                                                .padding()
                                                .overlay(
                                                    Capsule()
                                                        .strokeBorder(.gray, lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
