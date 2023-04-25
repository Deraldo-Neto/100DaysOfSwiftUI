//
//  ContentView.swift
//  BucketList
//
//  Created by Deraldo on 21/11/22.
//

//import LocalAuthentication
import SwiftUI
import MapKit

//struct User: Identifiable, Comparable { //Comparable serve para comparar (menor que, maior que , etc)
//    let id = UUID()
//    let firstName: String
//    let lastName: String
//
//    static func <(lhs: User, rhs: User) -> Bool { //lhs: left hand side, rhs: right hand side. SIM, O MÉTODO SE CHAMA MENOR QUE(<)
//        lhs.lastName < rhs.lastName
//    }
//}









//enum LoadingState {
//    case loading, success, failed
//}
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading...")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success!")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed.")
//    }
//}







//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}

struct ContentView: View {
    //let users = [
        //User(firstName: "Arnold", lastName: "Rimmer"),
        //User(firstName: "Kristine", lastName: "Kochanski"),
        //User(firstName: "David", lastName: "Lister")
    //].sorted() //.sorted {
        //$0.lastName < $1.lastName //Isso aqui funciona, porem, toda vez que eu quiser meus usuários embaralhados, vou ter que fazer esse sorted aqui
    //} //.sorted() não funciona aqui como funciona em um array, para isso eu preciso fazer uma função na minha struct
    
    //var loadingState = LoadingState.loading
    
    
    
    
    
    //@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    //let locations = [
        //Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        //Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    //]
    
    
    
    
    
    
    //@State private var isUnlocked = false
    
    
    @StateObject private var viewModel = ViewModel() //Eu colocar o @StateObject significa que toda vez qeu eu chamar a ViewModel dentro da minha SwiftUI View, ela estará no Main Actor.
    
    var body: some View {
        //List(users) { user in
            //Text("\(user.firstName) \(user.lastName)")
        //}
        
        
        
        
        
        
        
        //Text("Hello, world!")
        //    .onTapGesture {
        //        let str = "Test Message"
        //        let url = getDocumentsDirectory().appendingPathComponent("message.txt")
        //
        //        do {
        //            try str.write(to: url, atomically: true, encoding: .utf8) //Ao tentar salvar o documento no meu celular, eu preciso passar a url, que é o arquivo que vou baixar, se vai ser de forma atomica ou não (salvar tudo de uma vez) e a forma do arquivo, que no swift é utf8
                    
    //                let input = try String(contentsOf: url)
    //                print(input)
    //            } catch {
    //                print(error.localizedDescription)
    //            }
    //        }
    //
    //}
    //func getDocumentsDirectory() -> URL {
    //    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //    return paths[0]
    //}
    
        
        
        
        
        
        
        //switch loadingState {
        //case .loading:
        //    LoadingView()
        //case .success:
        //    SuccessView()
        //case .failed:
        //    FailedView()
        //}
        
        
        
        
        //NavigationView {
            //Map(coordinateRegion: $mapRegion,annotationItems: locations) { location in
                //MapMarker(coordinate: location.coordinate) //posso deixar só um pin
                //MapAnnotation(coordinate: location.coordinate) {
                    //NavigationLink { //Posso colocar um navigation link pra ele ir para um link quando eu clico
                        //Text(location.name)
                    //} label : {
                        //Circle()
                            //.stroke(.red, lineWidth: 3)
                            //.frame(width: 44, height: 44)
                    //}
                        //.onTapGesture { //Posso colocar um tap gesture no circle pra hora que clicar ele fazer alguma coisa
                        //    print("Tapped on \(location.name)")
                        //}
                    //VStack { //Posso colocar um circulo nos meus locais, junto com um texto
                    //    Circle()
                    //        .stroke(.red, lineWidth: 3)
                    //        .frame(width: 44, height: 44)
                    //
                    //    Text(location.name)
                    //}

                //}
            //}
            //.navigationTitle("London Explorer")
        //}
        
        
        
        
        //VStack {
            //if isUnlocked {
                //Text("Unlocked")
            //} else {
                //Text("Locked")
            //}
        //}
        //.onAppear(perform: authenticate)
        
        
        
        
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack { // Ao clicar no mais, ele adiciona uma nova localização no centro da tela
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("Authentication error!", isPresented: $viewModel.authError) {
                Button("OK") {
                    viewModel.authenticate()
                }
            }
        }
    }
    
    
    //func authenticate() { //função para desbloquear a tela com touch ID ou Face ID
        //let context = LAContext()
        //var error: NSError?
        
        //if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) { //touch ID ou Face ID
            //let reason = "We need to unlock your data"
            
            //context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError //in
                //if success {
                    //isUnlocked = true
                //} else {
                    //there was a problem
                //}
            //}
        //} else {
            //no biometrics
        //}
    //}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
