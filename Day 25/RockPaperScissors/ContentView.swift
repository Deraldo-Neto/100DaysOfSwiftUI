//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Deraldo on 02/06/22.
//

import SwiftUI

struct Options: View {
    var option: String
    
    var body: some View {
        Text(option)
            .frame(width: 100, height: 100)
            .font(.system(size: 75))
            .background(Color(red: 0.24, green: 0.69, blue: 0.26))
            .clipShape(Capsule())
            .padding()
    }
}

struct ContentView: View {
    let options = ["👊","🤚","✌️"]
    
    @State private var score = 0
    @State private var question = 0
    @State private var playerHaveTo = Bool.random()
    @State private var choice = Int.random(in: 0...2)
    @State private var resetGame = false
    
    var body: some View {
        ZStack {
            Color(red: 0.90, green: 1.00, blue: 0.78)
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 50) {
                    VStack {
                        Text("Rock, Paper, Scissors!")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(red: 0.27, green: 0.43, blue: 0.11))
                        Text("You have to \(playerHaveTo ? "win" : "lose")")
                            .font(.title)
                            .foregroundColor(Color(red: 0.27, green: 0.43, blue: 0.11))
                    }
                    
                    ZStack {
                        Text(options[choice])
                            .frame(width: 200, height: 200)
                            .font(.system(size: 150))
                            .background(Color(red: 0.24, green: 0.69, blue: 0.26))
                            .clipShape(Capsule())
                    }
                }
                Spacer()
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button{
                            result(option)
                        } label: {
                            Options(option: option)
                        }
                    }
                
                }
                Spacer()
                VStack {
                    Text("Question number: \(question)")
                        .font(.title)
                        .foregroundColor(Color(red: 0.27, green: 0.43, blue: 0.11))
                    Text("Score: \(score)")
                        .font(.title)
                        .foregroundColor(Color(red: 0.27, green: 0.43, blue: 0.11))
                }
                Spacer()
            }
        }
        .alert("You finished the game!", isPresented: $resetGame) {
            Button("Restart", action: restart)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    func result(_ option: String) {
        question += 1
        if question <= 10 {
            if playerHaveTo {
                playerHaveToWin(option)
            } else {
                playerHaveToLose(option)
            }
            choice = Int.random(in: 0...2)
            playerHaveTo = Bool.random()
        } else {
            resetGame = true
        }
    }
    
    func playerHaveToWin(_ option: String) {
        switch options[choice] {
            case "👊":
                if option == "🤚" {
                    score += 1
                } else {
                    (score > 0) ? (score -= 1) : (score = 0)
                }
            case "🤚":
                if option == "✌️" {
                    score += 1
                } else {
                    (score > 0) ? (score -= 1) : (score = 0)
                }
            case "✌️":
                if option == "👊" {
                    score += 1
                } else {
                    (score > 0) ? (score -= 1) : (score = 0)
                }
            default:
                score = 0
        }
    }
    
    func playerHaveToLose(_ option: String) {
        switch options[choice] {
            case "👊":
                if option == "✌️" {
                    score += 1
                } else {
                    (score > 0) ? (score -= 1) : (score = 0)
                }
            case "🤚":
                if option == "👊" {
                    score += 1
                } else {
                    (score > 0) ? (score -= 1) : (score = 0)
                }
            case "✌️":
                if option == "🤚" {
                    score += 1
                } else {
                    (score > 0) ? (score -= 1) : (score = 0)
                }
            default:
                score = 0
        }
    }
    
    func restart() {
        question = 0
        score = 0
        choice = Int.random(in: 0...2)
        playerHaveTo = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
