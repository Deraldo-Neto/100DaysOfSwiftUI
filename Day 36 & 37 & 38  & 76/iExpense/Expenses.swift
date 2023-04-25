//
//  Expenses.swift
//  iExpense
//
//  Created by Deraldo on 20/07/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet { //Com isso ele cria um JSON do meu ExpanseItem antes mesmo de armazenar no item, e então ele armazena como se fosse um cache
            
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    
    init() { //Inicialmente...
        if let savedItems = UserDefaults.standard.data(forKey: "Items") { //Eu verifico se tenho Items salvos...
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) { //Se sim eu tiro do Json e coloco na lista ExpenseItem e salvo no decodedItems, aqui tem que ser o .self pra dizer que é o próprio ExpenseItem, naõ uma específico.
                items = decodedItems //Falo pra ele que minha lista de items é o decoded Items e retorno
                return
            }
        }
        
        items = [] //Se não tiver nada eu retorno ela em branco
    }
}
