//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Deraldo on 03/10/22.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    public var wrappedTitle: String {
        title ?? "Unknown Title" //Se colocar vazio, ele coloca esse título, isso é pra não precisar colocar no código inteiro, coloca só aqui e já era
    }

}

extension Movie : Identifiable {

}
