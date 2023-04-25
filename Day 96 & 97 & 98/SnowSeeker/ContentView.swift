//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Deraldo on 10/04/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View { //Aqui temos o ViewBuilder por que um a gente retorna um modifier e o outro não
        if UIDevice.current.userInterfaceIdiom == .phone { //Estou rodando em um celular?
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

//Using groups as transparent layout containers
struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Deraldo")
            Text("Country: Brazil")
            Text("Pets: Lisa")
        }
        .font(.title)
    }
}

struct ContentView: View {
    //@State private var selectedUser: User? = nil
    //@State private var isShowingUser = false
    //@State private var layoutVertically = false
    //@Environment(\.horizontalSizeClass) var sizeClass //O equivalente ao de cima
    //@State private var searchText = ""
    //let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var isShowingSorted = false
    @State private var searchText = ""
    
    enum SortedType {
        case defaultOrder, alphabetical, country
    }
    
    @State private var sorted = SortedType.defaultOrder
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack { //Esse HStack corrige o problema de jogar o texto para a esquerda caso adicione um coração
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSorted = true
                    } label: {
                        Label("Sorted", systemImage: "list.bullet")
                    }
                    .confirmationDialog("Sorted", isPresented: $isShowingSorted) {
                        Button("Default") {
                            sorted = .defaultOrder
                        }
                        Button("Alphabetical") {
                            sorted = .alphabetical
                        }
                        Button("Country") {
                            sorted = .country
                        }
                    } message: {
                        Text("Sorted by:")
                    }
                }
            }
            
            WelcomeView() //Colocando aqui já resolve o problema com telas maiores, em portait mode some esse WelcomeView
        }
        .environmentObject(favorites) //Todo mundo tem acesso ao favorites
        //.phoneOnlyNavigationView() //Com isso não importa qual celular eu esteja usando, ele vai ter o comportamento normal e não vai precisar do WelcomeView, mas aqui optamos por usar o WelcomeView mesmo
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //NavigationView {
        //    NavigationLink {
        //        Text("New secondary") //Dependendo do tamanho da tela, ele cai direto aqui no New Secondary
        //    } label: {
        //        Text("Hello, world!")
        //    }
        //    .navigationTitle("Primary") //Dependendo do tamanho da tela, o NavigationView vai se comportar de forma diferente
            
        //    Text("Secondary") //Dependendo do tamanho da tela, esse Secondary vai aparecer em uma tela separada
        //
        //    Text("Tertiary") //Com esse, dependendo da tela, ele vai iniciar no Tertiary, se você der back, ele vai para o Secondary e ai pro Primary
        //}
        
        
        
        
        
        //Using alert() and sheet() with optionals
        //Text("Hello World!")
        //    .onTapGesture {
        //        selectedUser = User()
        //        isShowingUser = true
        //    }
        //    .alert("Welcome", isPresented: $isShowingUser) { } //Isso vai dar pra gente automaticamente um botão de ok
            //.alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in //É o equivalente a alerta do de baixo
               // Button(user.id) { }
            //}
            //.sheet(item: $selectedUser) { user in
            //    Text(selectedUser!.id)
            //}
        
        
        
        
        //Using groups as transparent layout containers
        //Group {
        //    if layoutVertically {
        //        VStack {
        //            UserView()
        //        }
        //    } else {
        //        HStack {
        //            UserView()
        //        }
        //    }
        //}
        //.onTapGesture {
        //    layoutVertically.toggle()
        //}
        
        //if sizeClass == .compact { //Equivalente ao de cima, só que mais inteligente, dependendo do tamanho da tela, ele age de forma diferente
        //    VStack {
        //        UserView()
        //    }
        //} else {
        //    HStack {
        //        UserView()
        //    }
        //}
        
        //if sizeClass == .compact { //Equivalente ao de cima, só que menor
        //    VStack(content: UserView.init)
        //} else {
        //    HStack(content: UserView.init)
        //}
        
        //Making a SwiftUI view searchable
        //NavigationView {
        //    List(filteredNames, id: \.self) { name in
        //        Text(name)
        //    }
        //    .searchable(text: $searchText, prompt: "Look for something") //Precisa puxar para baixo para aparecer a busca
        //    .navigationTitle("Searching")
        //}
    
    }
    
    //var filteredNames: [String] {
    //    if searchText.isEmpty {
    //        return allNames
    //    } else {
    //        return allNames.filter { $0.localizedStandardContains(searchText)} //O localized aqui é mais util pq pode procurar com as letras maiúsculas ou minúsculas, nã importa
    //    }
    //}
    
    
    
    
    
    
    
    
    
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var sortedResorts: [Resort] {
        switch sorted {
        case .defaultOrder:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
