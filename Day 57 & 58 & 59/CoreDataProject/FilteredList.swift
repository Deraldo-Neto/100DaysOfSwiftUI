//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Deraldo on 04/10/22.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View { //Método genérico, que vai lidar com banco de dados (NSManagedObject e também o conteúdo de nossa lista, as linhas, o que é um conteúdo do tipo View
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content //Eu te dou qualquer coisa e vc me da o Content dele que no caso é uma View, e que no caso desse projeto, é um texto.
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item) //Com isso daqui eu pego o content que tá no meu NSManaged e jogo o item pra dentro dele, substituindo as variáveis, no caso lá ele vai substituir os singer por item
        }
    }
    
    init(filterKey: String, predicate: Predicate, sortDescription: [NSSortDescriptor], filterValue: String, @ViewBuilder content: @escaping (T) -> Content) { //O @escaping está falando que vai ser usado depois, não agora, o ViewBuilder é para poder prover varias views.
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescription, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
