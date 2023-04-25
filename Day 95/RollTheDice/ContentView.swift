//
//  ContentView.swift
//  RollTheDice
//
//  Created by Deraldo on 27/03/23.
//

import SwiftUI
import CoreHaptics

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .leading))}
}

struct ContentView: View {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDice")
    @State private var engine: CHHapticEngine?
    
    @State private var showingSlidersOptions = false
    @State private var isShowingRecords = false
    @State private var rotation = 0.0
    @State private var opacity = 0.0
    
    @State private var dice = Dice()
    @State private var results = [Result]()
    @State private var dicesValues = [Result.DicesValues]()
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red:0.114, green: 0.110, blue: 0.898), Color(red:0.274, green: 0.286, blue: 1), Color(red:0.474, green: 0.470, blue: 1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        
                        if showingSlidersOptions {
                            VStack(spacing: 0) {
                                Text("Number of dices: \(String(format: "%.0f", dice.amount))")
                                Slider(value: $dice.amount, in: 1...100, step: 1.0)
                                    .scaleEffect(0.8)
                                Text("Number of sides: \(String(format: "%.0f", dice.sides))")
                                Slider(value: $dice.sides, in: 4...100, step: 2.0)
                                    .scaleEffect(0.8)
                            }
                            .transition(.backslide.combined(with: .opacity))
                        }
                        
                        VStack {
                            Button {
                                withAnimation {
                                    showingSlidersOptions.toggle()
                                    rotation = showingSlidersOptions == true ? -180 : 0
                                    opacity = showingSlidersOptions == true ? 1 : 0
                                }
                            } label: {
                                Image(systemName: "gearshape")
                                    .padding()
                                    .background(.black.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.white, lineWidth: 2)
                            )
                            .rotationEffect(.degrees(rotation))
                            
                            Button {
                                isShowingRecords = true
                            } label: {
                                Image(systemName: "doc.text")
                                    .padding()
                                    .background(.black.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.white, lineWidth: 2)
                            )
                            .sheet(isPresented: $isShowingRecords) {
                                RecordsView()
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .font(.title2)
                .padding()
                
                VStack {
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(0..<Int(dice.amount), id: \.self) { dado in
                                    if dice.values.isEmpty {
                                        DiceView(valueOfDice: Int(dice.sides), rotate: false)
                                    }
                                    else
                                    {
                                        if dice.values.count != Int(dice.amount) {
                                            DiceView(valueOfDice: Int(dice.sides), rotate: false)
                                        }
                                        else
                                        {
                                            DiceView(valueOfDice: dice.values[dado], rotate: true)
                                        }
                                        
                                    }
                                }

                            }
                            .animation(.interpolatingSpring(stiffness: 50, damping: 8), value: dice.amount)
                        }
                        .padding()
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Button {
                                dice.values.removeAll()
                                for _ in 0..<Int(dice.amount) {
                                    dice.values.append(Int.random(in: 2...Int(dice.sides)))
                                }
                                save()
                            } label: {
                                Image(systemName: "play")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(red:0.114, green: 0.110, blue: 0.898), Color(red:0.274, green: 0.286, blue: 1), Color(red:0.474, green: 0.470, blue: 1)]), startPoint: .top, endPoint: .bottom).opacity(0.8))
                                    .clipShape(Circle())
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(.white, lineWidth: 2)
                            )
                            .scaleEffect(1.2)
                            .onTapGesture(perform: prepareHeptics)
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    func save() {
        for dice in dice.values {
            dicesValues.append(Result.DicesValues(id: UUID(), value: dice))
        }
        
        results.append(Result(id: UUID(), date: Date.now, dicesValues: dicesValues))
        do {
            let data = try JSONEncoder().encode(results)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func prepareHeptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
