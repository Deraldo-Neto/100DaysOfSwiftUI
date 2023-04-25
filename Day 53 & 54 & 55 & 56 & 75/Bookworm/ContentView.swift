//
//  ContentView.swift
//  Bookworm
//
//  Created by Deraldo on 27/09/22.
//

import SwiftUI

//Creating a custom component with @Binding
//struct PushButton: View {
//    let title: String
    //@State var isOn: Bool //Tenho duas datas com valores diferentes, essa é local e a outra é externa, e uma não altera a outra, quando eu aperto o botão, ele altera o local, mas não o externo. O que eu preciso fazer é utilizar o @Binding, ai ele sabe que essa variável é a mesma que a outra
//    @Binding var isOn: Bool
//
//    var onColors = [Color.red, Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white: 0.4)]
//
//    var body: some View {
//        Button(title) {
//            isOn.toggle()
//        }
//        .padding()
//        .background(
//            LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom)
//        )
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//        .shadow(radius: isOn ? 0 : 5)
//    }
//}




//How to combine Core Data and SwiftUI


struct ContentView: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    
    @Environment(\.managedObjectContext) var moc //Serve para salvar
    //@FetchRequest(sortDescriptors: []) var students: FetchedResults<Student> //Faça uma requisição e me entregue em qualquer ordem e então coloque em uma propriedade chamada students o banco de dados Student
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title, order: .reverse), //Primeiro coloca na ordem inversa dos títulos
        SortDescriptor(\.author) //depois na ordem dos autores
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        //Creating a custom component with @Binding
        //VStack {
            //PushButton(title: "Remember Me", isOn: $rememberMe) //Aqui como é Binding, eu preciso do cifrão
            //Text(rememberMe ? "On" : "Off")
        //}
        
        
        
        //Accepting multi-line text input with TextEditor
        //NavigationView {
            //TextEditor(text: $notes)
                //.navigationTitle("Notes")
                //.padding()
        //}
        
        
        
        
        
        
        
        //How to combine Core Data and SwiftUI
        //VStack {
        //    List(students) { student in
        //        Text(student.name ?? "Unknown")
        //    }
        //
        //    Button("Add") {
        //        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
        //        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
        //
        //        let chosenFirstName = firstNames.randomElement()!
        //        let chosenLastName = lastNames.randomElement()!
        //
        //        let student = Student(context: moc)
        //        student.id = UUID()
        //        student.name = "\(chosenFirstName) \(chosenLastName)"
        //
        //        try? moc.save()
        //    }
        //}
        
        
        
        
        
        
        
        
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks) //ele já sabe o index por que ta dentro do foreach, por isso ele não passa o index
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    //Função para deletar uma informação do banco
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
