//
//  ContentView.swift
//  Day 19
//
//  Created by Deraldo on 24/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var lenght = 0.0
    @State private var input = "Meters"
    @State private var output = "Kilometers"
    @FocusState private var lenghtIsFocused: Bool
    
    let lenghts = ["Meters", "Kilometers","Feet","Yards", "Miles"]
    
    var result: Double {
        var retorno = 0.0
        if input == "Meters" {
            switch output {
                case "Meters":
                    retorno = lenght
                case "Kilometers":
                    retorno = lenght * 0.001
                case "Feet":
                    retorno = lenght * 3.28084
                case "Yards":
                    retorno = lenght * 1.094
                case "Miles":
                    retorno = lenght / 1609
                default:
                    retorno = lenght
            }
        }
        
        if input == "Kilometers" {
            switch output {
                case "Meters":
                    retorno = lenght * 1000
                case "Kilometers":
                    retorno = lenght
                case "Feet":
                    retorno = lenght * 3280.84
                case "Yards":
                    retorno = lenght * 1094
                case "Miles":
                    retorno = lenght / 1.609
                default:
                    retorno = lenght
            }
        }
        
        if input == "Feet" {
            switch output {
                case "Meters":
                retorno = lenght / 3.281
                case "Kilometers":
                    retorno = lenght / 3281
                case "Feet":
                    retorno = lenght
                case "Yards":
                    retorno = lenght / 3
                case "Miles":
                    retorno = lenght / 5280
                default:
                    retorno = lenght
            }
        }
        
        if input == "Yards" {
            switch output {
                case "Meters":
                    retorno = lenght / 1.094
                case "Kilometers":
                    retorno = lenght / 1094
                case "Feet":
                    retorno = lenght * 3
                case "Yards":
                    retorno = lenght
                case "Miles":
                    retorno = lenght / 1760
                default:
                    retorno = lenght
            }
        }
        
        if input == "Miles" {
            switch output {
                case "Meters":
                    retorno = lenght * 1609
                case "Kilometers":
                    retorno = lenght * 1.609
                case "Feet":
                    retorno = lenght * 5280
                case "Yards":
                    retorno = lenght * 1760
                case "Miles":
                    retorno = lenght
                default:
                    retorno = lenght
            }
        }
        return retorno
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input", selection: $input){
                        ForEach(lenghts, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input")
                }
                
                Section {
                    Picker("Output", selection: $output){
                        ForEach(lenghts, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output")
                }
                
                Section {
                    TextField("Lenght", value: $lenght, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($lenghtIsFocused)
                } header: {
                    Text("Lenght")
                }
                
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Result")
                }
                
            }
            .navigationTitle("Length Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        lenghtIsFocused = false
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
