//
//  Prospect.swift
//  HotProspects
//
//  Created by Deraldo on 27/02/23.
//

import Foundation
import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var date = Date()
    fileprivate(set) var isContacted = false //Isso faz com que o isContacted só possa ser alterado aqui dentro do prospect.swift e em mais nenhum lugar, mas ele pode ser visto ainda em todos os outros lugares, a gente faz isso para evitar bugs tentando alterar o contacted dentro do array e não sendo alterado na UI
}


@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect] //O Published só vai atualizar na tela se eu adicionar ou se eu remover ou modificar a LISTA de Prospects, caso eu altere UM Prospect, nada vai acontecer, não vai atualizar na tela, pq estamos modificando DENTRO do array. Foi colocado o private(set) para eu poder sempre ler de forma externa, mas nunca adicionar ou modificar de forma externa, encapsulando o array people
    
    //let saveKey = "SavedData"
    
    //init() {
    //    if let data = UserDefaults.standard.data(forKey: saveKey) {
    //        if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
    //            people = decoded
    //            return
    //        }
    //    }
    //
    //    //no saved data!
    //    people = []
    //}
    //
    //private func save() { //Somente Prospect.swift vai poder usar essa função
    //    if let enconded = try? JSONEncoder().encode(people) {
    //        UserDefaults.standard.set(enconded, forKey: saveKey)
    //    }
    //}
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    //Com essa função, people está encapsulado, pq só através dessa função conseguimos criar e salvar uma Prospect nova
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send() //antes de atualizarmos o valor temos que chamar essa função
        prospect.isContacted.toggle()
        save()
    }
}
