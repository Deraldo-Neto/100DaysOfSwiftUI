//
//  DiceView.swift
//  RollTheDice
//
//  Created by Deraldo on 27/03/23.
//

import SwiftUI

struct DiceView: View {
    let valueOfDice: Int
    @State var rotate: Bool
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var sumOfTime = 1
    @State private var valueOfDiceRotate = 1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
                .rotationEffect(.degrees(360))
            
            VStack {
                Text("\(valueOfDiceRotate)")
                    .font(.title2)
                    .bold()
            }
        }
        .frame(width: 50, height: 50)
        .onReceive(timer) { time in
            if sumOfTime > valueOfDice {
                sumOfTime = 1
                valueOfDiceRotate = valueOfDice
            }
            if rotate {
                if sumOfTime < valueOfDice {
                    sumOfTime += 1
                    valueOfDiceRotate = Int.random(in: 1..<sumOfTime)
                }
                else
                {
                    valueOfDiceRotate = valueOfDice
                }
            }
            else {
                valueOfDiceRotate = valueOfDice
            }
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(valueOfDice: 2, rotate: false)
    }
}
