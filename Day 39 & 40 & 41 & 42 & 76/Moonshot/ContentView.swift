//
//  ContentView.swift
//  Moonshot
//
//  Created by Deraldo on 25/07/22.
//

import SwiftUI

//How ScrollView lets us work with scrolling data
//struct CustomText: View {
//    let text: String
//
//    var body: some View {
//        Text(text)
//    }
//
//    init(_ text: String) {
//        print("Creating a new CustomText")
//        self.text = text
//    }
//}




//Working with hierarchical Codable data
//struct User: Codable {
//    let name: String
//    let address: Address
//}
//
//struct Address: Codable {
//    let street: String
//    let city: String
//}


//DAY 76: Para fazer o app ser acessível, é necessário colocar ele para falar como é as logos das missões, o nome da missão e a data.
struct GridLayout: View {
    var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    var missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        
                    Spacer()
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding()
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.darkBackground)
        }
    }
}

struct ContentView: View {
    //How to lay out views in a scrolling grid
    //let layout = [
        //GridItem(.fixed(80)), //Fixa em 80 pontos
        //GridItem(.fixed(80)),
        //GridItem(.fixed(80))
        //GridItem(.adaptive(minimum: 80)) //O tamanho mínimo é 80, mas se vc conseguir colocar mais colunas, coloque. Fica melhor na tela, vc pode girar ela e ele vai caber melhor
        //GridItem(.adaptive(minimum: 80, maximum: 120)) //Ajuda a deixar melhor do jeito que vc quer
    //]
    
    //day 40
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json") //Depois de colocar o tipo genérico no bundle, eu precisei colocar o tipo que é o astronauts, pra ele saber o que vai ser.
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    var body: some View {
        //Resizing images to fit the screen using GeometryReader
        //GeometryReader { geo in
        //    Image("Example")
        //        .resizable()
        //        .scaledToFit()
        //        //.scaledToFill()
        //        .frame(width: geo.size.width * 0.8) //Joga pro canto superior esquerdo e ocupa 80%
        //        .frame(width: geo.size.width, height: geo.size.height) // joga pro centro de tudo
        //}
        
        
        
        
        //How ScrollView lets us work with scrolling data
        //ScrollView(.horizontal) { //Horizontal, logicamente, faz ele ter uma barra horizontal, não vertical
            //LazyHStack(spacing: 10) { //Isso faz rodar de forma mais eficiente, ele vai criando conforme vc vai descendo a barrinha, não carrega tudo de uma vez, vai sobe demanda. E o LazyVStack ocupa todo o espaço da sua tela, diferente do VStack. Isso é intencional, pq o LazyVStack não sabe o tamanho que ele vai ficar
                //ForEach(0..<100) {
                    //CustomText("Item \($0)")
                        //.font(.title)
                //}
            //}
            //.frame(maxWidth: .infinity) //Aqui vc coloca um scroll na lateral pra saber aonde tá indicando
        //}
        
        
        
        //Pushing new views onto the stack using NavigationLink
        //NavigationView {
        //    List(0..<100) { row in //Muito útil! Consigo ir em outras telas e ver detalhes!
                //NavigationLink { //Serve para aparecer outras telas, mais detalhadas
                //    Text("Detail \(row)")
                //} label: {
                //    Text("Row \(row)")
                //        .padding()
                //}
            //}
            //.navigationTitle("SwiftUI")
        //}
        
        
        
        
        //Working with hierarchical Codable data
        //Button("Decode JSON") {
            //let input = """
                //{
                    //"name": "Taylor Swift",
                    //"address": {
                        //"street": "555, Taylor Swift Avenue",
                        //"city": "Nashville"
                    //}
                //}
            //"""
            
            //let data = Data(input.utf8)
            
            //if let user = try? JSONDecoder().decode(User.self, from: data) {
                //print(user.address.street)
            //}
        //}
        
        
        
        //How to lay out views in a scrolling grid
        //ScrollView(.horizontal) { //Tira o horizontal
        //    LazyHGrid(rows: layout) { //altera para columns e altera o H para V, caso queira deixar tudo Vertical
        //        ForEach(0..<1000) {
        //            Text("Item \($0)")
        //        }
        //    }
        //}
        
        
        //DAY 40
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark) //shift + command + e para trocar do dark para o light
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    if showingGrid {
                        Image(systemName: "rectangle.split.2x2.fill")
                    } else {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
