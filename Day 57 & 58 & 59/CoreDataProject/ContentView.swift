//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Deraldo on 29/09/22.
//

import SwiftUI
import CoreData

//struct Student: Hashable {
//    let name: String
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    //@FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    //@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "'Star Wars'")) var ships: FetchedResults<Ship> //Coloquei um filtro aqui pra me aparecer somente as naves do star wars
    
    //@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship> // A gente consegue fazer buscas bem complexas com esse predicate
    
    //@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe BEGINSWITH %@", "E")) var ships: FetchedResults<Ship> //Aqui é case sensitive
    
    //@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe CONTAINS[c] %@", "e")) var ships: FetchedResults<Ship> //Ignora o case sensitive
    
    //@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    
    @State private var lastNameFilter = "A"
    
    let arrayPredicate: Array<Predicate> = Predicate.allCases
    
    @State private var predicate = Predicate.beginWith
    
    let sortDescription = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]
    
    //@FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    //let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
    var body: some View {
        
        //Why does \.self work for ForEach?
        //List {
            //ForEach(students, id: \.self) { student in //\.self: use todo pedaço de data, o self faz o swift pegar o valor hash desse array, e só funciona pq a struct é Hashble. O problema aqui é, caso vc não coloque um UUID no core data, e crie uma data exatamente igual a outra, você vai ter um problema, pq o código hashable dele vai ser exatamente o mesmo. Detalhe, caso vc reinicie o swift ou coisa parecisa, os valores hash podem mudar, então eles não são uma garantia, caso vc queira usar. Se eu tenho 2 valores iguais, o hash deles são iguais, mas quando eu reinicio a aplicação eles continuam iguais mas com outro valor
                //Text(student.name)
            //}
        //}
        
        //Conditional saving of NSManagedObjectContext
        //Button("Save") {
        //    if moc.hasChanges { //Salva só se ouve modificações
        //        try? moc.save()
        //    }
        //}
        
        
        
        
        
        //Ensuring Core Data objects are unique using constraints
        //VStack {
        //    List(wizards, id: \.self) { wizard in
        //        Text(wizard.name ?? "Unknown")
        //    }
        //
        //    Button("Add") {
        //        let wizard = Wizard(context: moc)
        //        wizard.name = "Harry Potter" //Como o nome é uma CONSTRAINT, não pode ter nomes iguais. Com a modificação do DataController, ele da merge em tudo e salva só um
        //    }
        //
        //    Button("Save") {
        //        do {
        //            try moc.save()
        //        } catch {
        //            print(error.localizedDescription)
        //        }
        //    }
        //}
        
        
        
        
        
        //Filtering @FetchRequest using NSPredicate
        //VStack {
        //    List(ships, id: \.self) { ship in
        //        Text(ship.name ?? "Unknown name")
        //    }
        //
        //    Button("Add Examples") {
        //        let ship1 = Ship(context: moc)
        //        ship1.name = "Enterprise"
        //        ship1.universe = "Star Trek"
        //
        //        let ship2 = Ship(context: moc)
        //        ship2.name = "Defiant"
        //        ship2.universe = "Star Trek"
        //
        //        let ship3 = Ship(context: moc)
        //        ship3.name = "Millennium Falcon"
        //        ship3.universe = "Star Wars"
        //
        //        let ship4 = Ship(context: moc)
        //        ship4.name = "Executor"
        //        ship4.universe = "Star Wars"
        //    }
        //}
        
        
        
        
        //
        VStack {
            FilteredList(filterKey: "lastName", predicate: predicate, sortDescription: sortDescription, filterValue: lastNameFilter) { (singer: Singer) in //Como aqui é um NSManaged, eu preciso falar pra ele o que é o singer, que é um Singer, e lá na outra tela, ele transforma tudo o que é T em Singer
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)") //Em FilteredList, ele pede pra gente um content, e aqui a gente escreve a função do content
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
        
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
        
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
        
                try? moc.save()
            }
        
            Button("Begins with S") {
                lastNameFilter = "S"
                predicate = Predicate.beginWith
            }
        
            Button("Ends with S") {
                lastNameFilter = "s"
                predicate = Predicate.endWith
            }
        }
        
        
        
        
        
        
        
        //One-to-many relationships with @FetchRequest and SwiftUI
        //VStack {
        //    List {
        //        ForEach(countries, id: \.self) { country in
        //            Section(country.wrappedFullName) {
        //                ForEach(country.candyArray, id: \.self) { candy in
        //                    Text(candy.wrappedName)
        //                }
        //            }
        //        }
        //    }
        //
        //    Button("Add Examples") {
        //        let candy1 = Candy(context: moc)
        //        candy1.name = "Mars"
        //        candy1.origin = Country(context: moc)
        //        candy1.origin?.shortName = "UK"
        //        candy1.origin?.fullName = "United Kingdom"
        //
        //        let candy2 = Candy(context: moc)
        //        candy2.name = "KitKat"
        //        candy2.origin = Country(context: moc)
        //        candy2.origin?.shortName = "UK"
        //        candy2.origin?.fullName = "United Kingdom"
        //
        //        let candy3 = Candy(context: moc)
        //        candy3.name = "Twix"
        //        candy3.origin = Country(context: moc)
        //        candy3.origin?.shortName = "UK"
        //        candy3.origin?.fullName = "United Kingdom"
        //
        //        let candy4 = Candy(context: moc)
        //        candy4.name = "Toblerone"
        //        candy4.origin = Country(context: moc)
        //        candy4.origin?.shortName = "CH"
        //        candy4.origin?.fullName = "Switzerland"
        //
        //        try? moc.save()
        //    }
        //}
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
