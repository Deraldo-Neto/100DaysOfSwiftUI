//
//  AstronautView.swift
//  Moonshot
//
//  Created by Deraldo on 27/07/22.
//

//DAY 76: Aqui precisa explicar a história do tripulante
import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!) //A exclamação é pra falar "Olha, eu tenho ctz que isso vai funcionar, eu sei q é opcional, mas vai funcionar, confia!
    }
}
