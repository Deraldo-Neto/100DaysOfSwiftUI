//
//  LoadData.swift
//  Day60
//
//  Created by Deraldo on 27/10/22.
//

import Foundation
import SwiftUI
import CoreData

class Users {
    
    static func LoadDataFromJson() async -> [User] {
        
        //if !users.isEmpty { //não é mais útil aqui.
            //return
        //}
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL.")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 //Precisei desse dateDecodingStrategy por conta do formato da data, sem isso ele dava erro
            if let decodedResponse = try? decoder.decode([User].self, from: data) { //Note que aqui eu precisei colocar uma lista de Users
                
                //Passa os usuários para o banco de dados
                return decodedResponse
            }
        } catch {
            print("Invalid data.")
        }
        
        return []
    }
    
    static func SaveDataToDB(users: [User], moc: NSManagedObjectContext) async {
        DispatchQueue.main.async {
            if users.isEmpty {
                print("List of Users is Empty!")
                return
            }
            
            var tempUsers = [CachedUser]()
            
            for user in users {
                let newUser = CachedUser(context: moc)
                newUser.id = user.id
                newUser.name = user.name
                newUser.isActive = user.isActive
                newUser.age = Int16(user.age)
                newUser.company = user.company
                newUser.email = user.email
                newUser.address = user.address
                newUser.about = user.about
                newUser.registered = user.registered
                tempUsers.append(newUser)
            }

            for i in 0..<users.count {
                for friend in users[i].friends {
                    let newFriend = CachedFriend(context: moc)
                    newFriend.id = friend.id
                    newFriend.name = friend.name
                    
                    tempUsers[i].addToFriends(newFriend)
                }
            }
            
            do {
                try moc.save()
            } catch let error {
                print("Could not save data \(error.localizedDescription)")
            }
        }
    }
}
