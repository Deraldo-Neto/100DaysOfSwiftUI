//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Deraldo on 02/12/22.
//

import Foundation
import LocalAuthentication
import MapKit

//Fazer a separação de uma ViewModel Assim, torna mais fácil fazer testes
extension ContentView { //Colocando a extensio fazemos com que essa não seja apenas uma view model comum, mas sim a view model do ContentView.
    @MainActor class ViewModel: ObservableObject { //Aqui eu tenho o ObservableObject para que podemos reportar mudanças para todas as views do SwiftUI que estão "de olho". Já o @MainActor significa que ele é responsável por rodar todas as atualizações de interface do usuário e também significa que todo o seu código (a menos quie a gente especifique que não) seja executado aqui, no main actor. Isso é importante porque ele é resposável por fazer as atualizações da interface do usuário, e essas devem acontecer no main actor. Utilizar o @MainActor junto ao ObservableObject significa que todas as partes dessa classe devem ser executadas no main actor, para que seja seguro atualizar a interface do uisuário, não importa onde esteja usado. Sempre que colocamos o @StateObject ou o @ObservedObject, o swift infere de forma silenciosa o atributo @MainActor para nós, ele entende que ambos significam que a view do SwiftUI depende de um objeto externo para acionar suas atualizaç~eos de interface do usuário, e, portanto, garantirá que todo o trabalho acontece automaticamente no main actor sem que peçamos, mas isso não garante 100% de segurança, já que você pode acessar sua classe de outro lugar, de outra classe por exemplo, então o código pode ser executado em qualquer lugar, não sendo seguro.
        //Leitura de dados
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location] //Isso siginifica que: ler as localizações tudo bem, mas escrever não! Somente essa classe pode escrever nas locations
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        @Published var authError = false
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces") //Colocamos uma nova propriedade para que armazenemos o local onde iremos salvar nossa localização
        
        init() { //Faz a leitura dos dados assim que desbloqueia o celular
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() { //Função para salvar as informações do mapa, essa abordagem é interessante que eu consigo colocar qualquer quantidade de dados e a quantidade de arquivos que eu quiser, é muito mais optimizado do que o UserDefaults, e também nos permite carregar e salvar datas assim que o app é iniciado
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        //Manipulação de dados
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) { //Pega o lugar selecionado
                locations[index] = location //Procura o lucar selecionado e coloca esse newLocation no lugar dele
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself  to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in //Aqui eu preciso dessa task por que quando eu desbloqueio o celular, quem faz isso é o celular, e não o app, se eu não tiver essa parte assincrona ele vai funcionar mas vai emitir um alerta dizendo que você não pode alterar as informações do app através de uma thread externa, e diz para você faze-las na thread principal, então é necessário esperar com que o app esteja desbloqueado para você alterar a informação do Unlocked. E o @MainActor está dizendo para ele rodar essa Task em todo o MainActor, então ao invés de sair da task externa e voltar para a task principal, essa task com o @ vai imediatamente começar a rodar no MainActor
                                self.isUnlocked = true
                        }
                    } else {
                        Task { @MainActor in
                            self.authError = true
                            
                        }
                    }
                }
            } else {
                Task { @MainActor in
                    self.authError = true
                    
                }
            }
        }
    }
}

