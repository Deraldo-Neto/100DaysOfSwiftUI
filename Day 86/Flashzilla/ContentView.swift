//
//  ContentView.swift
//  Flashzilla
//
//  Created by Deraldo on 09/03/23.
//

import SwiftUI


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    //@State private var cards = Array<Card>(repeating: Card.example, count: 10) //Cria 10 card examples
    @State private var cards = [Card]()
    
    @State private var timerRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack { //Tem tudo + uma imagem de fundo
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack { //Esse tem o timer
                Text("Time: \(timerRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack { //Esse tem a lista de cartas
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) { answer in
                            withAnimation {
                                removeCard(at: index, answer: answer) //Quando eu removo a carta, eu quero que as outras passem para cima, por isso aqui é com uma animação
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1) //Só é possível pegar a carta do topo
                        .accessibilityHidden(index < cards.count - 1)
                    }
                }
                .allowsHitTesting(timerRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, answer: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, answer: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return } //se o isActive não for true, sai fora do timer e não faz nada
            
            if timerRemaining > 0 {
                timerRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false { //Só ativa o timer se eu tiver carta
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init) //Só pode ser usado assim por que o EditCards não precisa de nenhuma propriedade
        .onAppear(perform: resetCards)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func removeCard(at index: Int, answer: Bool) {
        guard index >= 0 else { return } //Não tente remover cartas que não existem
        
        let card = cards.remove(at: index)
        
        if !answer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //Adiciona de forma assincrona uma nova carta
                self.cards.insert(card, at: 0)
            }
        }
        
        if cards.isEmpty { //Travo o tempo quando acabo as cartas
            isActive = false
        }
    }
    
    
    func resetCards() {
        //cards = Array(repeating: Card.example, count: 10) //Não precisa deixar o <Card> aqui que ele vai saber do que se trata
        timerRemaining = 100
        isActive = true
        loadData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
