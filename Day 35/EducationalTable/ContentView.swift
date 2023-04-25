//
//  ContentView.swift
//  EducationalTable
//
//  Created by Deraldo on 26/06/22.
//

import SwiftUI

struct CircleButton: View {
    var option: Int
    
    var body: some View {
        Text("\(option)")
            .frame(width: 50, height: 50)
            .font(.system(size: 25))
            .foregroundColor(.white)
            .background(Color(red: 0.57254902, green: 0.70588235, blue: 0.9254902))
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct AnimalButton: View {
    var option: String
    var animationRotation: Double
    
    var body: some View {
        Image("\(option)")
            .renderingMode(.original)
            .resizable()
            .frame(width: 50, height: 45)
            .shadow(radius: 5)
            .rotation3DEffect(
                .degrees(animationRotation),
                 axis: (x: 0, y: 1, z: 0)
            )
            .animation(.default, value: animationRotation)
    }
}

struct RectangleNumber: View {
    var text: String
    
    var body: some View {
        Text("\(text)")
            .font(.system(size: 40.0))
            .frame(maxWidth: 100)
            .padding(.vertical, 20)
            .background(Color(red: 1, green: 0.82352941, blue: 0.29803922))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct OptionButton: ViewModifier {
    var canTap: Bool
    var option: Int
    var enabled: Int?
    var animationOpacity: Double
    var animationAmount: Double
    var reset: Bool
    var tableFinished: [Int]
    
    func body(content: Content) -> some View {
        content
            .allowsHitTesting(canTap)
            .opacity((option == enabled) ? (1 - animationOpacity) : 1.0)
            .animation(.default, value: animationOpacity)
            .overlay(overlayBuilder)
    }
    
    @ViewBuilder private var overlayBuilder: some View {
        if !reset {
            Circle()
                .stroke(Color(red: 1, green: 0.82352941, blue: 0.29803922))
                .scaleEffect((option == enabled) ? animationAmount : 0.0)
                .opacity((option == enabled) ? (2 - animationAmount) : 2.0)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false)
                    , value: animationAmount
                )
        }
    }
}

extension View {
    func buttonStyle(_ canTap: Bool, _ option: Int, _ enabled: Int?, _ animationOpacity: Double, _ animationAmount: Double, _ reset: Bool, _ tableFinished: [Int]) -> some View {
        modifier(OptionButton(canTap: canTap, option: option, enabled: enabled, animationOpacity: animationOpacity, animationAmount: animationAmount, reset: reset, tableFinished: tableFinished))
    }
}
struct ContentView: View {
    @State private var table = 2
    @State private var tableFinished: [Int] = []
    @State private var animals = ["cow", "bear", "chicken","giraffe","elephant","horse","monkey","panda","penguin","pig","zebra"]
    @State private var questions = [5, 10, 20]
    @State private var whatQuestion = 1
    @State private var number = Int.random(in: 2...12)
    
    @State private var canTap = true
    @State private var enabled: Int? = nil
    @State private var animationOpacity = 0.0
    @State private var animationAmount = 0.0
    
    @State private var nQuestions = 5
    @State private var canTapQuestion = true
    @State private var questionSelectEnabled: Int? = nil
    @State private var animationOpacityQuestion = 0.0
    @State private var animationAmountQuestion = 0.0
    
    @State private var answer: Int? = nil
    @State private var stateQuestion = false
    @State private var score = 0
    @State private var answerTitle = ""
    @State private var reset = false
  
    @State private var resetAnimation = false
    @State private var animationRotation = 1.0
    @State private var textFinished = ""
    @State private var messageFinished = ""
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Section {
                    VStack {
                        VStack {
                            Text("Choose one table:")
                                .font(.title3.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                ForEach(2...7, id: \.self) { option in
                                    Button {
                                        if !tableFinished.contains(option) {
                                            optionButton(option)
                                        }
                                    } label: {
                                        if !tableFinished.contains(option) {
                                            CircleButton(option: option)
                                        }
                                        else
                                        {
                                            AnimalButton(option: animals[option - 2], animationRotation: animationRotation)
                                        }
                                    }
                                    .buttonStyle(canTap, option, enabled, animationOpacity, animationAmount, reset, tableFinished)
                                }
                                Spacer()
                            }
                            
                            HStack {
                                ForEach(8...12, id: \.self) { option in
                                    Button {
                                        if !tableFinished.contains(option) {
                                            optionButton(option)
                                        }
                                    } label: {
                                        if !tableFinished.contains(option) {
                                            CircleButton(option: option)
                                        }
                                        else
                                        {
                                            AnimalButton(option: animals[option - 2], animationRotation: animationRotation)
                                        }
                                    }
                                    .buttonStyle(canTap, option, enabled, animationOpacity, animationAmount, reset, tableFinished)
                                }
                                Spacer()
                                
                            }
                        }
                        .padding(.vertical)
                        
                        VStack {
                            Text("How many questions?")
                                .font(.title3.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                ForEach(questions, id: \.self) { question in
                                    Button {
                                        optionQuestion(question)
                                    } label: {
                                        CircleButton(option: question)
                                    }
                                    .buttonStyle(canTapQuestion, question, questionSelectEnabled, animationOpacityQuestion, animationAmountQuestion, reset, tableFinished)
                                }
                                Spacer()
                            }
                        }
                        .opacity(canTap ? 0 : 1.0)
                        .transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        
                        Section {
                            VStack {
                                Text("What is...")
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                HStack {
                                    RectangleNumber(text: "\(table)")
                                    
                                    Text("x")
                                        .font(.system(size: 50.0))
                                    
                                    RectangleNumber(text: "\(number)")
                                    
                                    Text("=")
                                        .font(.system(size: 50.0))
                                    
                                    TextField("?", value: $answer, format: .number)
                                        .keyboardType(.decimalPad)
                                        .focused($amountIsFocused)
                                        .font(.system(size: 40.0))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 100)
                                        .padding(.vertical, 20)
                                        .background(Color(red: 1, green: 0.82352941, blue: 0.29803922))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 1, green: 0.90196078, blue: 0.60392157))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.vertical)
                            .alert(answerTitle, isPresented: $stateQuestion) {
                                Button("Continue", action: nextQuestion)
                            } message: {
                                Text("Your score is \(score)")
                            }
                            .alert(textFinished, isPresented: $reset) {
                                Button("Continue", action: resetGame)
                            } message: {
                                Text(messageFinished)
                            }
                            VStack {
                                Text("This is the question number: \(whatQuestion)")
                                    .font(.headline)
                            }
                            
                            Spacer()
                        }
                        .opacity(canTapQuestion ? 0 : 1.0)
                        .transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        
                    }
                    
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Educational Table")
                                .font(.title2.bold())
                            Text("Save the animals finishing the tables!")
                                .font(.title3.bold())
                        }
                        .opacity(!amountIsFocused ? 1.0 : 0)
                        .animation(.default, value: amountIsFocused)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    amountIsFocused = false
                    questionFunc()
                }
            }
        }
            
    }
    
    func optionButton(_ option: Int) {
        table = option
        enabled = option
        animationOpacity = 0.5
        animationAmount = 2.0
        withAnimation(.easeInOut(duration: 1)) {
            canTap = false
        }
        
    }
    
    func optionQuestion(_ question: Int) {
        nQuestions = question
        questionSelectEnabled = question
        animationOpacityQuestion = 0.5
        animationAmountQuestion = 2.0
        canTapQuestion = false
    }
    
    func questionFunc() {
        if whatQuestion <= nQuestions {
            if (table * number) == answer {
                answerTitle = "Correct"
                score += 1
            } else {
                answerTitle = "Wrong! The correct answer is: \(table * number)"
            }
            stateQuestion.toggle()
        }
    }
    
    func nextQuestion() {
        number = Int.random(in: 2...12)
        answer = nil
        
        if whatQuestion == nQuestions {
            if score == nQuestions {
                textFinished = "Congratulations!"
                messageFinished = "You finished the table of \(table)!"
                tableFinished.append(table)
            }
            else
            {
                textFinished = "Oh no!"
                messageFinished = "You didn't get all the questions right, please, try again!"
            }
            reset.toggle()
        }
        if whatQuestion < nQuestions {
            whatQuestion += 1
        }
    }
    
    func resetGame() {
        score = 0
        whatQuestion = 1
        stateQuestion = false
        
        enabled = nil
        canTap = true
        animationOpacity = 0.0
        animationAmount = 0.0
        
        questionSelectEnabled = nil
        canTapQuestion = true
        animationOpacityQuestion = 0.0
        animationAmountQuestion = 0.0
        animationRotation += 360
        resetAnimation.toggle()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
