//
//  ContentView.swift
//  HotProspects
//
//  Created by Deraldo on 27/02/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var prospect = Prospects() //Aqui eu crio uma unica instancia da classe Prospects
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospect) //Colocamos a propriedade que criamos no nosso environment para todas as nossas views filhas consigam ter acesso
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
