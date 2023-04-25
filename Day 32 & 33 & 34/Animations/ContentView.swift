//
//  ContentView.swift
//  Animations
//
//  Created by Deraldo on 22/06/22.
//

import SwiftUI

//struct CornerRotateModifier: ViewModifier { //Retorno uma modificação na view
//    let amount: Double
//    let anchor: UnitPoint
//
//    func body(content: Content) -> some View { //Pego tudo o que tenho dentro do corpo da view
//        content
//            .rotationEffect(.degrees(amount), anchor: anchor) // Rotaciono passando a amount e a anchor
//            .clipped() //Serve para não mostrar o quadrado que está se formando de fora
//    }
//}
//
//extension AnyTransition { //Modifico a extensão AnyTransition
//    static var pivot: AnyTransition { //Quando eu chamo o pivot, eu retorno um modifier
//        .modifier(
//            active: CornerRotateModifier(amount: -90, anchor: .topLeading), //No ativo eu jogo a struct CornerRotateModifier passando amount -90 e o anchor .topLeading
//            identity: CornerRotateModifier(amount: 0, anchor: .topLeading) //No identity eu faço o mesmo mas passando 0 pro amount
//        )
//    }
//}

struct ContentView: View {
    @State private var animationAmount = 0.0
    //@State private var enabled = false
    //@State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    
    //let letters = Array("Hello, SwiftUI")
    
    var body: some View {
        //Aqui atracamos a animação a view
//        Button("Tap Me") {
//            animationAmount -= 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(
//                    .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: false) // reverse serve para reverter a operação depois que finaliza
//                    , value: animationAmount
//                )
//
//        )
//        .onAppear {
//            animationAmount = 2
//        } // junto com o overlay, coloca um efeito bem legal, o circulo aumenta e diminui ligeiramente e cria um círclo em volta
        //.scaleEffect(animationAmount) //Aumenta a escala do botão
        //.blur(radius: (animationAmount - 1) * 3) // Inicia com o blur no 0, por isso o - 1
        //.animation(.default, value: animationAmount) //Deixa suave a animação default para aquela view com o valor do animationAmount (No caso o default é um ease in e ease out)
        //.animation(.easeOut, value: animationAmount) //Inicie rápido e finalize devagar
        //.animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount) //Vai e volta
        //.animation(.easeInOut(duration: 2), value: animationAmount) //Dura 2 segundos para fazer a animação
        //.animation(
            //.easeInOut(duration: 2)
            //.delay(1),
            //value: animationAmount
        //) //Coloco um delay de 1 segundo para iniciar a animação
        //.animation(
            //.easeInOut(duration: 1)
            //.repeatCount(3, autoreverses: true)
            //, value: animationAmount
        //) //Repete o movimento 3x
        //.animation(
            //.easeInOut(duration: 1)
            //.repeatForever(autoreverses: true)
            //, value: animationAmount
        //) //Repete o movimento pra sempre
        
        
        
        //print(animationAmount)
        
//        return VStack {
//            //aqui atracamos a animação a uma dado
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                .repeatCount(3, autoreverses: true)
//            ), in: 1...10) //O Stepper faz a animação ser suave, junto ao .animation(), com esse tipo de animation, eu não preciso declarar qual a variação da mudança, por que ele já tá atrelado. Esse tipo de binding é bom por que nos explicitamente animamos quando a mudança do state. Então no primeiro, o state não faz ideia de que vai acionar uma animação, e nesse, a view não faz ideia de que será animada, ambos funcionam e são importantes
//
//            Spacer()
//
//            Button("Tap Me") {
//                animationAmount += 1
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
        
        
        //Terceira maneira de fazer uma animação: pedindo explicitamente ao swift para animar as mudanças que ocorrem como resultado de uma mudança do state
//        Button("Tap Me") {
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) { //withAnimation consegue fazer todas as outras animações que o .animation faz
//                animationAmount += 360
//            }
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        
        
        
        
        //DAY 33
//        Button("Tap Me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .blue : .red)
//        //.animation(nil, value: enabled) //Eu posso desativar a animação, assim a cor vai mudar rapido, ou seja, cancelando o animation ali de baixo
//        //.animation(.default, value: enabled) //Veja só! eu consigo colocar quantas animações eu quiser, o que acontece é que essa vai rodar a parte de cima, e a de baixo, o restante.
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled) //Isso faz com que a troca de cor seja suave, não se esqueça que a ordem importa! se eu colocar o clipShape em baixo, ele não vai ser animado
        
        
        //Gestures
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount) //Serve para poder segurar o objeto
//            .gesture(
//                DragGesture()
//                    .onChanged { dragAmount = $0.translation } // Move o objeto
//                    .onEnded { _ in
//                        withAnimation {
//                            dragAmount = .zero //Anima pra voltar pro estado inicial
//                        }
//                    } //Volta pro estado inicial
//            )
//            .animation(.spring(), value: dragAmount) //Com isso existe um delay no arrastar
        
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(
//                        .default.delay(Double(num) / 20), //Faz com que as letras sigam, dando um efeito bem legal
//                        value: dragAmount)
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
        
        
        
        //Showing and hiding views with transitions
      VStack {
          Button("Tap Me") {
              withAnimation { //Fica bem melhor o aparecimento do quadrado com a animação
                  isShowingRed.toggle()
              }
          }

          if isShowingRed {
              Rectangle()
                  .fill(.red)
                  .frame(width: 200, height: 200)
                  .transition(.scale) //Se vc colocar o transition, ele aparece devagar, fica bem mais bonito
                  .transition(.asymmetric(insertion: .scale, removal: .opacity)) //2 tipos de transição, ele escala bonitinho quando aparece e some tirando opacidade, uma transição assimétrica
          }
      }
        
        
        //Building custom transitions using ViewModifier
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 200, height: 200)
//
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.pivot) //Quando eu chamo a transition, eu faço aquela transição que eu criei
//            }
//        }
//        .onTapGesture {
//            withAnimation {
//                isShowingRed.toggle()
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
