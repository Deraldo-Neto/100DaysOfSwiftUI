//
//  MissionView.swift
//  Moonshot
//
//  Created by Deraldo on 27/07/22.
//

//DAY 76: Aqui precisa explicar a logo, a data da missão, como ela se sucedeu e o nome dos tripulantes
import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack { //centro
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6) //ocupa 60% da tela, pra ficar mais bonito
                        .padding(.top)
                    Text("\(mission.formattedLaunchDate)")
                        .font(.title2.bold())
                    
                    
                    VStack(alignment: .leading) { //esquerda
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                         Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            )
                                        
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) { //Ao iniciar, eu pego as missões e os astronautas
        self.mission = mission //self.mission é a variável dentro da MissionView, então eu jogo as missões pra aqui dentro
        
        self.crew = mission.crew.map { member in //eu armazeno dentro da minha variável crew (que é um array de CrewMember) os astronautas que pertenceram aquela missão, junto com sua função
            if let astronaut = astronauts[member.name] { //Aqui eu vejo se dentro do dicionário dos astronautas eu tenho alguém com esse nome, esse nome é tirado do CrewMember da missão.
                return CrewMember(role: member.role, astronaut: astronaut) //Se tiver, ele armazena no self.crew o CrewMember com a função, tirada da missão, e as informações do astronauta específico
            } else {
                fatalError("Missing \(member.name)") //Caso ele não encontre nada, ele dá erro
            }
        }
    }

}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
