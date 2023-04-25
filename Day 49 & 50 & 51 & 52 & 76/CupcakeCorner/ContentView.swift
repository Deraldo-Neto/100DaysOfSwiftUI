//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Deraldo on 14/09/22.
//

import SwiftUI

//Adding Codable conformance for @Published properties:
//class User: ObservableObject, Codable { //Se minha classe é codable, minhas propriedades também são
//    enum CodingKeys: CodingKey {
//        case name
//    }
    
//    @Published var name = "Deraldo" //Eu não posso ter uma variável que seja Published, ou seja, monitorada pelo swift dentro de uma classe codable, por isso preciso fazer toda essa tratativa
    
//    required init(from decoder: Decoder) throws { //caso eu não queira o required aqui, eu preciso colocar a class como final. Observe que aqui eu tenho um type chamado Decoder, que contem toda a nossa data, e aqui precisamos saber lidar com ela. O Required é pq eu preciso sempre passar por aqui pra poder editar os valores
//        let container = try decoder.container(keyedBy: CodingKeys.self) //tento fazer um decoder no meu enum
//        name = try container.decode(String.self, forKey: .name) //tento o decoder da minha chave para uma string
//    }
    
//    func encode(to encoder: Encoder) throws { //Essa função é o contrário, aqui é pra colocar meu enum em um Json, então eu preciso fazer o encoder dele.
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}







//Sending and receiving Codable data with URLSession and SwiftUI:
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}


struct ContentView: View {
    //@State private var results = [Result]()
    
    //@State private var username = ""
    //@State private var email = ""
    
    @StateObject var order = Order()
    
    var body: some View {
        //Sending and receiving Codable data with URLSession and SwiftUI:
        //List(results, id: \.trackId) { item in
        //    VStack(alignment: .leading) {
        //        Text(item.trackName)
        //            .font(.headline)
        //        Text(item.collectionName)
        //    }
        //}
        //.task {
        //    await loadData()
        //}
        
        
        
        //Loading an image from a remote server:
        //AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in //Ele não trata a imagem não, joga do jeito que pegar. Modificador não funciona aqui, pq os modificadores são do AsyncImage, e não da imagem dentro dela. Então tenho que colocar essa função dentro do asyncImage
            //image
                //.resizable()
                //.scaledToFit()
        //} placeholder: {
            //ProgressView()
        //}
        //.frame(width: 200, height: 200)
        
        //AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            //if let image = phase.image {
                //image
                    //.resizable()
                    //.scaledToFit()
            //} else if phase.error != nil {
                //Text("There was an error loading the image.")
            //} else {
                //ProgressView()
            //}
        //}
        //.frame(width: 200, height: 200)
        
        
        
        
        
        
        
        //Validating and disabling forms:
        //Form {
            //Section {
                //TextField("Username", text: $username)
                //TextField("Email", text: $email)
            //}
            
            //Section {
                //Button("Create account") {
                    //print("Creating account...")
                //}
            //}
            //.disabled(disableForm)
        //}
    //}
    
    //var disableForm: Bool {
        //username.count < 5 || email.count < 5
    //}
    
        
        
        
        
        
        
        
    //Sending and receiving Codable data with URLSession and SwiftUI:
    //func loadData() async {
    //    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
    //        print("Invalid URL")
    //        return
    //    }
    //
    //    do {
    //        let (data, _) = try await URLSession.shared.data(from: url) //não importa a metadata, por isso o underscore
    //        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
    //            results = decodedResponse.results
    //        }
    //    } catch {
    //        print("Invalid data")
    //    }
    //}
        
        
        
        
        
        
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderStruct.type) { //Caso queira usar a classe, é só tirar o structOrder
                    ForEach(OrderStruct.types.indices) {
                        Text(OrderStruct.types[$0])
                    }
                }
                    
                    Stepper("Number of cakes: \(order.orderStruct.quantity)", value: $order.orderStruct.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.orderStruct.specialRequestEnabled.animation())
                    
                    if order.orderStruct.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderStruct.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.orderStruct.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
