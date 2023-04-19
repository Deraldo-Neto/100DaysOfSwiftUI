//
//  ContentView.swift
//  WeSplit
//
//  Created by Deraldo on 19/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool //O FocusState serve para lidar com input focus no nosso projeto
    
    //let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        //Calculamos o total por pessoa aqui
        let peopleCount = Double(numberOfPeople + 2) //quando eu escolho 2 pessoas, no foreach é como se ele tivesse entendendo 1 (0 dps 1), então eu preciso somar com 2
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalPlusTip: Double {
        checkAmount * ((Double(tipPercentage) / 100) + 1)
    }
    
    var localMoney: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView { //Eu preciso do navigationView para conseguir fazer com que o picker jogue para a outra tela
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localMoney)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused) //Se eu quero texto, coloco text como modifier, se e quero decimal, coloco value, e eu consigo colocar qual o formato que eu quero do TextField com o format, dentro do code do format, eu verifico o valor da minha localização atual, se eu não encontrar coloco dolar. Decimalpad como pode imaginar é pra alterar o teclado pra ser sempre número, mas ele não impede de digitar teclas, mas o swift identifica e não permite
                        //o focused serve para ter o foco ou não do objeto, se não tá focado, amoutIsFocused é false, e ele some, se estiver, dai vai true e ele fica na tela
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                //Section {
                    //Picker("Tip percentage", selection: $tipPercentage) {
                        //ForEach(tipPercentages, id: \.self) {
                            //Text($0, format: . percent)
                        //}
                    //}
                    //.pickerStyle(.segmented) //Isso faz com que ele coloque de forma segmentada as informações do picker
                //} header: { //Esse header serve para colocar coisas acima da Section, um título por exemplo
                    //Text("How much tip do you want to leave?")
                //}
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: localMoney)
                } header: {
                    Text("Amount per person")
                }
                .foregroundColor((tipPercentage == 0) ? .red : .primary)
                
                Section {
                    Text(totalPlusTip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total plus tip")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar { //Serve para colocar uma toolbar no projeto
                ToolbarItemGroup(placement: .keyboard) { //Deixa a gente colocar um ou mais botões em lugares específicos, no nosso caso, queremos no teclado, um toolbar ficado no teclado, que vai aparecer e desaparecer com ele.
                    Spacer() //Deixa um espaço, nesse caso, ele joga para a direita o Done, por que eu estou dentro do toolbar, é uma convenção
                    Button("Done") { //Botão com um texto de Done
                        amountIsFocused = false //Caso clique no botão, ele passa o amountIsFocused para false, caso ele seja falso, ele vai sumir com o teclado
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
