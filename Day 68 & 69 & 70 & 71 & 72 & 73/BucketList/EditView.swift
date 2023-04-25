//
//  EditView.swift
//  BucketList
//
//  Created by Deraldo on 23/11/22.
//

import SwiftUI

struct EditView: View {
    @StateObject private var viewModel = ViewModel(location: Location.example)
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void //coloque no onSave a localização e não espere nada de retorno
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID() //O objeto mudou, preciso mudar o UUID dele para ele saber que houve uma alteração, se não a comparação no Location não vai deixar alterar
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task( {
                await viewModel.fetchNearbyPlaces()
            })
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) { //O @escaping significa que ele não vai ser chamado imediatamente no initializer, ele vai ser chamado depois, dizendo para o swift preservar essa memória para que podemos chamar essa struct depois
        self.onSave = onSave
        
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in } //Aqui ignoramos o valor do onSave, por que ele não precisa fazer nada aqui
    }
}
