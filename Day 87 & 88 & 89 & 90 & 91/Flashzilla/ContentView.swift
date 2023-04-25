//
//  ContentView.swift
//  Flashzilla
//
//  Created by Deraldo on 07/03/23.
//

import SwiftUI
import CoreHaptics

//O que essa função faz é o seguinte: Eu estou com a redução de animação ligada? Se sim, eu não quero animação, faça tudo direto, sem o .withAnimation
//func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
//    if UIAccessibility.isReduceMotionEnabled {
//        return try body()
//    } else {
//        return try withAnimation(animation, body)
//    }
//}

struct ContentView: View {
    //@State private var currentAmount = 0.0
    //@State private var finalAmount = 1.0
    
    //@State private var currentAmount = Angle.zero
    //@State private var finalAmount = Angle.zero
    
    
    //@State private var offset = CGSize.zero
    //@State private var isDragging = false
    
    //@State private var engine: CHHapticEngine?
    
    
    //let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect() //A cada 1 segundo no main de maneira normal (seja escrollando seja com a tela parada), ele vai auto conectar esse timer imediatamente ao iniciar. A tolerancia é pra ajudar o sistema a dar uma "respirada"
    
    //@State private var counter = 0
    
    
    //@Environment(\.scenePhase) var scenePhase
    
    //@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor //Para daltonicos
    
    //@Environment(\.accessibilityReduceMotion) var reduceMotion //Tira as animações
    //@State private var scale = 1.0
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        //How to use gestures in SwiftUI
        //let dragGesture = DragGesture()
        //    .onChanged { value in
        //        offset = value.translation
        //    }
        //    .onEnded { _ in
        //        withAnimation {
        //            offset = .zero
        //            isDragging = false
        //        }
        //    }
        //
        //let pressGesture = LongPressGesture()
        //    .onEnded { value in
        //        withAnimation {
        //            isDragging = true
        //        }
        //    }
        //
        //let combined = pressGesture.sequenced(before: dragGesture)
        //
        //
        //Circle()
        //    .fill(.red)
        //    .frame(width: 64, height: 64)
        //    .scaleEffect(isDragging ? 1.5 : 1)
        //    .offset(offset)
        //    .gesture(combined)
        
        //VStack {
        //    Text("Hello, world!")
        //        .onTapGesture {
        //            print("Text tapped!")
        //        }
        //}
        //.simultaneousGesture( //Vai aparecer os 2 prints
        //    TapGesture()
        //        .onEnded {
        //            print("Vstack tapped")
        //        }
        //)
        //.highPriorityGesture( //Vai aparecer só o print de baixo, caso eu utilize o onTapGesture, vai imprimir só o de cimas
        //    TapGesture()
        //        .onEnded {
        //            print("Vstack tapped")
        //        }
        //)
        
        
        //Text("Hello, world!")
            //.rotationEffect(currentAmount + finalAmount)
            //.gesture(
            //    RotationGesture()
            //        .onChanged { angle in
            //            currentAmount = angle
            //        }
            //        .onEnded { angle in
            //            finalAmount += currentAmount
            //            currentAmount = .zero
            //        }
            //)
            //.scaleEffect(finalAmount + currentAmount)
            //.gesture(
            //    MagnificationGesture()
            //        .onChanged { amount in
            //            currentAmount = amount - 1
            //        }
            //        .onEnded { amount in
            //            finalAmount += currentAmount
            //            currentAmount = 0
            //        }
            //)
            //.padding()
            //.onLongPressGesture(minimumDuration: 1) {
            //    print("Long pressed!")
            //} onPressingChanged: { inProgress in //Ele começa como true e assim que dá o tempo do long press gesture ele passa a ser falso
            //    print("In progress: \(inProgress)")
            //}
            //.onTapGesture(count: 2) {
            //    print("Double tapped!")
            //}
        
        
        
        
        
        
        
        
        
        
        
        //Making vibrations with UINotificationFeedbackGenerator and Core Haptics
        //Text("Hello, world!")
        //    //.padding()
        //    //.onTapGesture(perform: simpleSuccess)
        //    .onAppear(perform: prepareHeptics)
        //    .onTapGesture(perform: complexSuccess)
        
        
        
        
        
        
        
        
        
        
        
        
        //Disabling user interactivity with allowsHitTesting()
        //ZStack {
        //    Rectangle()
        //        .fill(.blue)
        //        .frame(width: 300, height: 300)
        //        .onTapGesture {
        //            print("Rectangle tapped!")
        //        }
        //
        //    Circle()
        //        .fill(.red)
        //        .frame(width: 300, height: 300)
        //        .contentShape(Rectangle()) //Isso faz com que por de trás dos panos, o circulo seja um retangulo, então aonde eu clicar agora, ele vai falar que o circulo foi tocado
        //        .onTapGesture {
        //            print("Circle tapped!")
        //        }
                //.allowsHitTesting(false) //isso aqui faz com que o onTapGesture do circle não funcione, ai só vai funcionar o do retangulo
        //}
        
        //VStack {
        //    Text("Hello")
        //    Spacer().frame(height: 100)
        //    Text("World")
        //}
        //.contentShape(Rectangle()) //Com isso eu posso clicar em qualquer lugar
        //.onTapGesture { //Sem o contentShape, eu tenho que clicar em cima do Hello ou em cima do World, qualquer coisa entre, não vai funcionar
        //    print("VStack tapped!")
        //}
        
        
        
        
        
        
        
        
        
        
        //Triggering events repeatedly using a timer
        //Text("Hello, world!")
        //    .onReceive(timer) { time in
        //        if counter == 5 {
        //            timer.upstream.connect().cancel()
        //        } else {
        //            print("The time is now \(time)") //Vai imprimindo o tempo infinitamente
        //        }
        //
        //        counter += 1
        //    }
        
        
        
        
        
        
        
        
        
        
        
        //How to be notified when your SwiftUI app moves to the background
        //Text("Hello, world!")
        //    .padding()
        //    .onChange(of: scenePhase) { newPhase in
        //        if newPhase == .active { //tá rodando e visível pro usuário
        //            print("Active")
        //        } else if newPhase == .inactive { //Tá visível pro usuário mas ele não consegue acessar (carregando por exemplo, ou até puxando a barra em cima)
        //            print("Inactive")
        //        } else if newPhase == .background { //Tá minimizado
        //            print("Background")
        //        }
        //    }
        
        
        
        
        
        
        
        
        //Supporting specific accessibility needs with SwiftUI
        //HStack {
        //    if differentiateWithoutColor {
        //        Image(systemName: "checkmark.circle")
        //    }
        //
        //    Text("Success")
        //}
        //.padding()
        //.background(differentiateWithoutColor ? .black : .green)
        //.foregroundColor(.white)
        //.clipShape(Capsule())
        
        //Text("Hello, world!")
        //    .scaleEffect(scale)
        //    .onTapGesture {
        //        withOptionalAnimation {
        //            scale *= 1.5
        //        }
        //    }
        
        //Text("Hello, world!")
        //    .padding()
        //    .background(reduceTransparency ? .black : .black.opacity(0.5))
        //    .foregroundColor(.white)
        //    .clipShape(Capsule())
        
    }
    
    //Making vibrations with UINotificationFeedbackGenerator and Core Haptics
    //func simpleSuccess() {
    //    let generator = UINotificationFeedbackGenerator()
    //    generator.notificationOccurred(.success)
    //}
    //
    //func prepareHeptics() {
    //    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    //
    //    do {
    //        engine = try CHHapticEngine()
    //        try engine?.start()
    //    } catch {
    //        print("There was an error creating the engine: \(error.localizedDescription)")
    //    }
    //}
    
    //func complexSuccess() {
    //    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    //
    //    var events = [CHHapticEvent]()
    //
    //    for i in stride(from: 0, to: 1, by: 0.1) { //Vai vibrando devagar até chegar na intensidade máxima
    //        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
    //        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
    //        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: i)
    //        events.append(event)
    //    }
    //
    //    for i in stride(from: 0, to: 1, by: 0.1) { //Começa vibrando na intensidade máxima e vai diminuindo
    //        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
    //        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
    //        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 1 + i)
    //        events.append(event)
    //    }
    //
    //    do {
    //        let pattern = try CHHapticPattern(events: events, parameters: [])
    //        let player = try engine?.makePlayer(with: pattern)
    //        try player?.start(atTime: 0)
    //    } catch {
    //        print("Failed to play pattern \(error.localizedDescription)")
    //    }
    //
    //}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
