//
//  ContentView.swift
//  iExpense
//
//  Created by Deraldo on 19/07/22.
//

import SwiftUI

struct BorP: View {
    var item: ExpenseItem
    var type: String
    
    var body: some View {
        if item.type == type {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }
                
                Spacer()
                
                Text(item.amount, format: .currency(code: "USD"))
                    .foregroundColor((item.amount < 10) ? .red : (item.amount >= 10 && item.amount <= 100) ? .yellow : .green)
            }
            .accessibilityElement()
            .accessibilityLabel("\(item.name), \(item.amount)")
            .accessibilityHint("\(item.type)")
        }
    }
}

//Struct: sempre tem propriedades exclusivas e  Class: várias coisas podem apontar para o mesmo valor e não precisam da palavra-chave mutating antes dos métodos que alteram suas propriedades, por que vc pode alterar as propriedades das classes constantemente
//Basicamente: se eu tiver 2 structs iguais, elas não compartilham as informações, já classe sim. Por exemplo, se eu alterar a struct User para Class, na hora de trocar o primeiro nome no app, não vai trocar no Text, por conta do @State.
//class User: ObservableObject { //Outros irão monitorar essa classe, por isso o Observable Object, ele é um protocolo
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}



//Showing and hiding views
//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//
//    let name: String
//
//    var body: some View {
//        Text("Hello \(name)!")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}



//Archiving Swift objects with Codable
//struct User: Codable { //Isso faz com que ele salva o Usuário para gente como se fosse um "cache" (mas na verdade é um json)
//    let firstName: String
//    let lastName: String
//}



struct ContentView: View {
    //Quando eu declaro uma @State (uma mutating) para uma Class, e tento modificar com um TextField, por exemplo, ele modifica sim a Class, mas não modifica a variável. Ele não vê os valores que estão dentro da Class, ele não vê que isso modifica, o @State só vê a classe por sí só.
    //A gente usa o @StateObject quando a gente faz os dados pela primeira vez, caso eu queira pegar essa classe em outra View, eu uso @ObservedObject.
    //@StateObject var user = User() //Como se tivesse dizendo: Observe os objetos que estão publicados. Aqui a gente remove o private por que a gente quer compartilhar essas informações com outros. Ou seja, ela não é privada
    
    //@State private var user = User() //O que acontece aqui na prática é que: quando uma variável muda, toda a struct muda, ou seja: é uma nova struct que é criada
    
    
    //Showing and hiding views
    //@State private var showingSheet = false
    
    
    //Deleting items using onDelete()
    //@State private var numbers = [Int]()
    //@State private var currentNumber = 1
    

    
    //Storing user settings with UserDefaults
    //@State private var tapCount =  UserDefaults.standard.integer(forKey: "Tap") //O valor padrão para o int é 0. Não se esqueça que ele demora um pouco pra salvar, se vc fechar de uma vez, vai perder as informações
    //@AppStorage("tapCount") private var tapCount = 0 //Outra maneira de se fazer, mas é bem mais fácil de se usar.
    //Lembre-se: nã oé uma boa ideia armazenar uma struct, por exemplo, e um AppSotorage.
    
    
    
    //Archiving Swift objects with Codable
    //@State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    //Building a list we can delete from
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        //VStack {
        //    Text("Your name is \(user.firstName) \(user.lastName)")
        //
        //    TextField("First name", text: $user.firstName)
        //    TextField("Last name", text: $user.lastName)
        //}
        
        
        //Showing and hiding views
        //Quando clicar no botão, vai aparecer outra folha na frente
        //Button("Show Sheet") {
        //    showingSheet.toggle()
        //}
        //.sheet(isPresented: $showingSheet) {
        //    SecondView(name: "@xderaldoneto")
        //}
        
        
        //Deleting items using onDelete()
        //NavigationView {
        //    VStack {
        //        List {
        //            ForEach(numbers, id: \.self) {
        //                Text("Row \($0)")
        //            }
        //            .onDelete(perform: removeRows)
        //        }
        //
        //        Button("Add Number") {
        //            numbers.append(currentNumber)
        //            currentNumber += 1
        //        }
        //    }
        //    .navigationTitle("onDelete()")
        //    .toolbar {
        //        EditButton()
        //    }
        //}
        
        
        
        //Storing user settings with UserDefaults
        //Button("Tap count: \(tapCount)") {
        //    tapCount += 1
        //    //UserDefaults.standard.set(tapCount, forKey: "Tap") //Salva um cache chamado Tap. E eu não preciso disso quando uso o @AppStorage
        //}
        
        
        
        //Archiving Swift objects with Codable
        //Button("Save User") {
        //    let encoder = JSONEncoder()
        //
        //    if let data = try? encoder.encode(user) {
        //        UserDefaults.standard.set(data, forKey: "UserData")
        //    } //Salva nosso user como "cache"
        //}
        
        
        
        //Building a list we can delete from
        NavigationView {
            Section {
                List {
                    Section(header: Text("Business expenses")) {
                        ForEach(expenses.items) { item in
                            BorP(item: item, type: "Business")
                        }
                        .onDelete(perform: removeItems)
                        
                    }
                    
                    Section(header: Text("Personal expenses")) {
                        ForEach(expenses.items) { item in
                            BorP(item: item, type: "Personal")
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
        
    }
    
    //Deleting items using onDelete()
    //func removeRows(at offsets: IndexSet) {
    //    numbers.remove(atOffsets: offsets)
    //}
    
    
    //Building a list we can delete from
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
