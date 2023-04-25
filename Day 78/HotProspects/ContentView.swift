//
//  ContentView.swift
//  HotProspects
//
//  Created by Deraldo on 31/01/23.
//

import SwiftUI
import UserNotifications
import SamplePackage

//@MainActor class User: ObservableObject {
//    @Published var name = "Taylor Swift"
//}
//
//struct EditView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        TextField("Name", text: $user.name)
//    }
//}
//
//struct DisplayView: View {
//    @EnvironmentObject var user: User //Já existe um usuário no environment, pegue ele. (No caso, está na classe User)
//
//    var body: some View {
//        Text(user.name)
//    }
//}





//Mannually publishing ObservableObject changes
//@MainActor class DelayedUpdater: ObservableObject {
    //@Published var value = 0 //Graças ao Published, ele sempre vai ficar atualizando o nosso value, pq deixa de chamar o UI
//
//    var value = 0 {
//        willSet {
//            objectWillChange.send() //tem o mesmo comportamento do de cima, a diferença é que com o willSet eu posso adicionar informações extras
//        }
//    }
//
//    init() {
//        for i in 1...10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.value += 1
//            }
//        }
//    }
//}



struct ContentView: View {
    //@StateObject var user = User()
    //@State private var selectedTab = "One"
    //@StateObject private var updater = DelayedUpdater()
    //@State private var output = ""
    //@State private var backgroundColor = Color.red
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        //VStack {
            //EditView().environmentObject(user) //Observe que tanto esse quanto o de baixo vai imprimir "Taylor Swift". Detalhe, caso eu modifique um deles, todos irão modificar, por que tdos vem da classe User
            //DisplayView().environmentObject(user)
            //EditView()
            //DisplayView()
        //}
        //.environmentObject(user) //Vai funcionar da mesma maneira que os dois de cima.
        
        
        
        
        
        
        //TabView(selection: $selectedTab) {
        //    Text("Tab 1")
        //        .onTapGesture {
        //            selectedTab = "Two"
        //        }
        //        .tabItem {
        //            Label("One", systemImage: "star")
        //        }
        //
        //    Text("Tab 2")
        //        .tabItem {
        //            Label("Two", systemImage: "circle")
        //        }
        //        .tag("Two")
        //}
        
        
        
        
        
        
        //Mannually publishing ObservableObject changes
        //Text("Value is \(updater.value)")
        
        
        
        
        
        
        
        
        
        //Undestanding Swift's Result type
        //Text(output)
        //    .task {
        //        await fetchReadings()
        //    }
        
        
        
        
        
        
        
        
        
        
        //Controlling image interpolation in SwiftUI
        //Image("example")
        //    .interpolation(.none) //tira o blur da imagem
        //    .resizable()
        //    .scaledToFit()
        //    .frame(maxHeight: .infinity)
        //    .background(.black)
        //    .ignoresSafeArea()
        
        
        
        
        
        
        
        
        //Creating context menus
        //VStack {
        //    Text("Hello, world!")
        //        .padding()
        //        .background(backgroundColor)
        //
        //    Text("Change Color")
        //        .padding()
        //        .contextMenu { //Se você segurar o texto, vai aparecer os botões para você escolher, não adianta colocar um foreground color nesse botão pq não vai funcionar
        //           Button(role: .destructive) { //Deixa a cor do botão em vermelho
        //               backgroundColor = .red
        //           } label: {
        //               Label("Red", systemImage: "checkmark.circle.fill")
        //           }
        //
        //           Button("Green") {
        //               backgroundColor = .green
        //         }
        //
        //         Button("Blue") {
        //             backgroundColor = .blue
        //         }
        //     }
        //}
        
        
        
        
        
        
        
        //Adding custom row swipe actions to a List
        //List {
        //    Text("Taylor Swift")
        //        .swipeActions {
        //            Button(role: .destructive) {
        //                print("Deleting")
        //            } label: {
        //                Label("Delete", systemImage: "minus.circle")
        //            }
        //        }
        //        .swipeActions(edge: .leading) {
        //            Button {
        //                print("Pinning")
        //            } label: {
        //                Label("Pin", systemImage: "pin")
        //            }
        //            .tint(.orange)
        //        }
        //}
        
        
        
        
        
        
        
        
        //Scheduling local notifications
        //VStack {
        //    Button("Request Permission") { //Peço a permissão para poder enviar notificações
        //        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        //            if success {
        //                print("All set!")
        //            } else if let error = error {
        //                print(error.localizedDescription)
        //            }
        //        }
        //    }
        //
        //    Button("Schedule Notification") { //Faço o envio de notificação
        //        let content = UNMutableNotificationContent()
        //        content.title = "Feed the dogs"
        //        content.subtitle = "They look hungry"
        //        content.sound = UNNotificationSound.default
        //
        //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //
        //        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        //
        //        UNUserNotificationCenter.current().add(request)
        //    }
        //}
        
        
        
        
        
        
        
        
        
        //Adding Swift package dependencies in Xcode
        Text(results)
        
    }
    //Undestanding Swift's Result type
    //func fetchReadings() async {
    //    let fetchTask = Task { () -> String in
    //        let url = URL(string: "https://hws.dev/readings.json")!
    //        let (data, _) = try await URLSession.shared.data(from: url)
    //        let readings = try JSONDecoder().decode([Double].self, from: data)
    //        return "Found \(readings.count) readings."
    //    }
    //
    //    let result = await fetchTask.result //Aqui ele vai me retornar uma string ou um error, e o resultado vai armazenar isso
    //
    //    switch result {
    //    case .success(let str):
    //        output = str
    //    case .failure(let error):
    //        output = "Download error: \(error.localizedDescription)"
    //    }
    //}
    
    
    
    
    
    //Adding Swift package dependencies in Xcode
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
