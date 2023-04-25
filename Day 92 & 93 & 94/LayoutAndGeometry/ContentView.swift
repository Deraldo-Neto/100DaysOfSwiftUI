//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Deraldo on 20/03/23.
//

import SwiftUI

extension VerticalAlignment { //Isso vai fazer com que quem esteja com o .midAccountAndName esteja sempre centralizado, não importa o que seja colocado em baixo ou em cima, eles vão centralizar entre ci
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Local center \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        print("Custon center \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                    }
            }
            .background(.orange)
        }
    }
}

struct ContentView: View { //O tamanho do Content View, é o tamanho do Body, chamamos isso de Layout neutral
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    func challenge2(geoSrollView: CGFloat, geoGlobal: CGFloat) -> Double {
        if geoSrollView > geoGlobal {
            return geoSrollView / geoGlobal
        } else if geoSrollView < geoGlobal {
            return geoSrollView / geoGlobal
        }
        
        return 1
    }
    
    func challenge3(minY: CGFloat, height: CGFloat) -> Double {
        return minY / height > 1 ? 1 : minY / height
    }
    
    var body: some View {
        //Text("Hello, world!") //Precisa da quantidade x e y de pixels para preencher o texto com a cor
         //   .padding(20) //Pergunta pro text qual a quantidade de pixels o text precisa, depois, adiciona 20 pontos de cada lado e ai joga pro background
         //   .background(.red) //Também é um Layout Neutral. Se você trocar a ordem, você vai ver que o tanto que ele preencher do espaço é diferente, isso é por que o background é um Layout neutral
        
        //Color.red //Também é um Layout Neutral. Layout Neutral podem preencher todo o espaço de tela
        
        
        
        
        //Text("Live long and prosper!")
            //.frame(width: 300, height: 300, alignment: .topLeading) //em cima no canto esquerdo
            //.offset(x: 50, y: 50) //joga + 50 para o x e para o y
        
        //HStack(alignment: .lastTextBaseline) { //lastTextBaseline coloca todos alinhados com o último texto
        //    Text("Live")
        //        .font(.caption)
        //    Text("long")
        //    Text("and")
        //        .font(.title)
        //    Text("prosper")
        //        .font(.largeTitle)
        //}
        
        //VStack(alignment: .leading) { //leading Alinha no canto a esquerda (mas depende, em outras linguas pode ser ao contrário)
            //Text("Hello, world!")
                //.alignmentGuide(.leading) { d in
                    //d[.trailing]
            
               // ForEach(0..<10) { position in
                    //Text("Number \(position)")
                        //.alignmentGuide(.leading) { _ in
                            //Double(position) * -10
                        //} //.leading aqui significa alterar a posição em -10
                //}
            //} //trata o .leading como .trailing
            //Text("This is a longer line of text")
        
        //.background(.red)
        //.frame(width: 400, height: 400)
        //.background(.blue)
        
        
        
        
        
        
        
        
        
        //HStack(alignment: .midAccountAndName) {
        //    VStack {
        //        Text("@xderaldoneto")
        //            .alignmentGuide(.midAccountAndName) { d in
        //                d[VerticalAlignment.center] //Aqui precisa ser explicitamente o Vertical
        //            }
        //        Image("deraldo")
        //            .resizable()
        //            .frame(width: 64, height: 64)
        //    }
        //}
        //
        //VStack {
        //    Text("Full Name:")
        //    Text("DERALDO NETO")
        //        .alignmentGuide(.midAccountAndName) { d in
        //            d[VerticalAlignment.center]
        //        }
        //        .font(.largeTitle)
        //}
        
        
        
        
        
        
        
        
        //Text("Hello, world!")
            //.offset(x: 100, y: 100)
            //.background(.red) //Quando fazemos isso, o centro fica na cor de fundo vermelha, mas o Hello, world é jogado pra outro lugar. Isso acontece pq a posição do hello world é a mesma, mas a renderização é em outro lugar, então quando colocamos o .background em baixo, estamos usando a posição original do Text, o offset não altera o background. Mas se você colocar o background em cima, ai sim a cor vai acompanhar, por que primeiro ele respeita o background pra depois fazer o offset
        
        //VStack {
        //    GeometryReader { geo in //Isso aqui vai cobrir toda a tela, mas ele vai colorir só a parte de cima da tela em 90%
          //      Text("Hello, world!")
          //          .frame(width: geo.size.width * 0.9)
          //          .background(.red)
          //  }
          //  .background(.green)
          //
          //  Text("More text")
          //  Text("More text")
          //  Text("More text")
          //  Text("More text")
        //        .background(.blue)
        //}

        
        
        
        
        //OuterView()
        //    .background(.red) ///Em cima e em baixo fica vermelho por que no nosso OuterView não tem background color entre os textos.
        ///E ele fica verde nas laterais por que nossos textos de esquerda e direita não possuem também um background e dentro do OuterView a gente define um .background(.green).
        ///Já o laranja é o GeometryReader, que foi definido com o laranja, nele temos o texto de Center em azul e quando clicamos ele dá pra gente algumas coordenadas:
        ///Nela, temos a coordenada Global, a local e a Custom, e todas elas estão diferentes. O Global mostra pra gente o centro do laranja pra gente, a coordenada exata.
        ///Já o Local, é a localização dele relativo ao parent. E o Custom é o o tamanho total menos as Safe Area
        //    .coordinateSpace(name: "Custom")
        
        
        
        
        
        //GeometryReader { fullView in //Esse aqui pega TODO o espaço disponível em tela
        //    ScrollView {
        //        ForEach(0..<50) { index in
        //            GeometryReader { geo in //Já aqui, pega somente os 40 de altura disponível
        //                Text("Row #\(index)")
        //                    .font(.title)
        //                    .frame(maxWidth: .infinity)
        //                    .background(colors[index % 7])
        //                    .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0)) //O primeiro GeometryReader mudou a orientação dos textos, agora está tudo na orientação certa
        //            }
        //            .frame(height: 40)
        //        }
        //    }
        //}
        
        
        
        //ScrollView(.horizontal, showsIndicators: false) {
        //    HStack(spacing: 0) {
        //        ForEach(1..<20) { num in
        //            GeometryReader { geo in
        //                Text("Number \(num)")
        //                    .font(.largeTitle)
        //                    .padding()
        //                    .background(.red)
        //                    .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
        //                    .frame(width: 200, height: 200)
        //            }
        //            .frame(width: 200, height: 200)
        //        }
        //    }
        //}
        
        
        
        
        
        
        
        
        
        
        
        
        //Day 94
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: challenge3(minY: geo.frame(in: .global).minY, height: fullView.size.height), saturation: 1.0, brightness: 1.0))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity((geo.frame(in: .global).minY) / 200.0) //Challange1
                            .scaleEffect(challenge2(geoSrollView: geo.frame(in: .global).midY, geoGlobal: fullView.frame(in: .global).midY))
                    }
                    .frame(height: 40)
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
