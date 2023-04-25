//
//  CardView.swift
//  Flashzilla
//
//  Created by Deraldo on 09/03/23.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: ((_ answer: Bool) -> Void)? = nil //Essa closure aceita nenhum parametro e envia nada de volta, é opcional para que não precisemos providenciar entradas a menos que quisermos
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(setColor(for: offset.width)) //Aqui foi alterado para a função para quando voltar, ele saber que não é maior que zero nem menor que zero, logo, tem que voltar a cor branca e não oscilar em verde e vermelho
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5))) //offset.width é o quanto eu arrastei para a esquerda ou direita
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton) //Para falar que é um botão
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    //Prepara a vibração, para evitar delays
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        //if offset.width > 0 {
                        //    feedback.notificationOccurred(.success)
                        //} else {
                        //    feedback.notificationOccurred(.error)
                        //}
                        if  offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }
                        removal?(offset.width > 0) //O interrogação significa que o closure só vai ser chamado se tiver sido definido
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset) //Faz a animação voltar mais suave
    }
    
    func setColor(for offset: CGFloat) -> Color {
        if offset > 0 {
            return .green
        } else if offset < 0 {
            return .red
        }
        
        return .white
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
