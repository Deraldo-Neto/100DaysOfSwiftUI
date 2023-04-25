//
//  ContentView.swift
//  BetterRest
//
//  Created by Deraldo on 07/06/22.
//

//Importando o ML
import CoreML
import SwiftUI

struct ContentView: View {
    //@State private var sleepAmount = 8.0
    //@State private var wakeUp = Date.now //Hora e dia
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    //@State private var alertTitle = ""
    //@State private var alertMessage = ""
    //@State private var showingAlert = false
    
    static var defaultWakeTime: Date { //precisa ser static para ser usado no wakeUp
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        //Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25) // in é a faixa, máx e min, step é o salto dos valores
        
        //Date picker
        //DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .date)
        //DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...) //só datas futuras
            //.labelsHidden() //Caso eu queira que suma o texto
        
        //Text(Date.now, format: .dateTime.hour().minute())
        //Text(Date.now.formatted(date: .long, time: .shortened))
        //Text(Date.now.formatted(date: .long, time: .omitted))
        
        NavigationView{
            Form {
                //Vou colocar entre VStacks para tirar o traço em baixo, deixar separado certinho. Poderia usar sections views também
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    //Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    Picker(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Text(calculateBedTime())
                } header: {
                    Text("Recommended bedtime")
                }
                
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert){
//                Button("OK") {}
//            } message: {
//                Text(alertMessage)
//            }
        }
    }
    
    func calculateBedTime() -> String {
        //Configura o ML
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp) //Me devolpa apenas a hora e o minuto de wakeUp
            let hour = (components.hour ?? 0) * 60 * 60 //Pego apenas a hora do wakeUp, caso não exista, pego 0, detalhe que já está convertido para segundos
            let minute = (components.minute ?? 0) * 60 //Pego apenas os minutos do wakeUp, caso não exista, pego 0, detalhe que já está convertido para segundos
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount)) //Aqui me monstra o quanto de sono ele precisa, aqui faz os calculos
            
            let sleepTime = wakeUp - prediction.actualSleep //hora que ele precisa dormir
            return sleepTime.formatted(date: .omitted, time: .shortened)
            //alertTitle = "Your ideal bedtime is..."
            //alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Error"
            //alertTitle = "Error"
            //alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        //showingAlert = true
    }
    
    //Func que pode ser usada no datePicker para colocar intervalo.
//    func exampleDate() {
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        let range = Date.now...tomorrow
//    }
    
//    func trivialExample() {
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? Date.now
        
    //Date component: Pode ser útil quando se quer pegar parte da hora ou para converter para um double
//        let components = Calendar.current.dateComponents(([.hour, .minute]), from: Date.now)
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
        
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
