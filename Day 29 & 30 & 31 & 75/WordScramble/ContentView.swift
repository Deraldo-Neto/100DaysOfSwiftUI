//
//  ContentView.swift
//  WordScramble
//
//  Created by Deraldo on 13/06/22.
//

import SwiftUI

struct ContentView: View {
    //let people = ["Finn", "Leia", "Luke", "Rey"]
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    var body: some View {
        //Muito parecido com o Form, mas ele consegue gerar conteúdo dinamicamente
//        List(0..<5) {
//            Text("Dynamic row \($0)")
//            Section("Section 1") {
//                Text("Static row 1")
//                Text("Static row 2")
//            }
//
//            Section("Section 2") {
//                ForEach(0..<5) {
//                    Text("Dynamic row \($0)")
//                }
//            }
//
//            Section("Section 3") {
//                Text("Static row 3")
//                Text("Static row 4")
//            }
//        }
//        .listStyle(.grouped)
        
//        List(people, id: \.self) {
//            Text($0)
//        }
        
//        List {
//            Text("Static row")
//
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//
//            Text("Static row")
//        }
//        .listStyle(.grouped)
        VStack {
            NavigationView {
                Section {
                    List {
                        Section {
                            TextField("Enter your word", text: $newWord)
                                .autocapitalization(.none) //Não inicia com a letra maiúscula
                        }
                        
                        Section {
                            ForEach(usedWords, id: \.self) { word in
                                HStack {
                                    Image(systemName: "\(word.count).circle") //Coloca dentro de um circulo o tamanho da palavra
                                    Text(word)
                                }
                                .accessibilityElement()
                                //.accessibilityLabel("\(word), \(word.count) letters.")
                                .accessibilityLabel(word)
                                .accessibilityHint("\(word.count) letters") //caso clique ele fala a quantidade de letras que tem a palavra
                            }
                        }
                    }
                }
                .navigationTitle(rootWord) //Coloca a rootWord como título
                .onSubmit(addNewWord) //Quando eu aperto enter
                .onAppear(perform: startGame) // Ao iniciar, roda essa função
                .toolbar {
                    Button("Restart", action: startGame)
                }
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }
            HStack {
                Text("Score: \(score)")
                    .font(.title)
                    .padding()
                Spacer()
            }
        }

    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) //deixo a nova palavra toda em minusculo e removo os espaços em branco e novas linhas, apenas do início e do fim
        guard answer.count > 0 else { return } //Verifica se a resposta é maior que zero
        
        guard isShorten(word: answer) else {
            wordError(title: "This word is not valiable!", message: "Tap another answer")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Work not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard  isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation { //Coloca uma animação na hora de inserir a nova palavra
            usedWords.insert(answer, at: 0) //Adiciona a resposta para o indice zero
            score += 10 * answer.count
        }
        newWord = "" //Limpa a newWord
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") { //abre o arquivo start.txt
            if let startWords = try? String(contentsOf: startWordsURL) { //transforma o txt em stirng e armazena em startWords
                let allWords = startWords.components(separatedBy: "\n") //cria um array com todas as palavras, separando o array através do \n
                rootWord = allWords.randomElement() ?? "silkworm" // armazena uma palavra aleatória no rootWord, caso não exista, coloca silkworm
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.") //Algo deu errado com o startWordsURL
    }
    
    //Verifica se a resposta tem tamanho maior que 3 ou é a palavra inicial
    func isShorten(word: String) -> Bool {
        if word == rootWord {
            return false
        }
        
        if word.count <= 3 {
            return false
        }
        return true
    }
    
    //Verifica duplicatas
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) //Verifico se já existe aquela palavra na minha lista
    }
    
    //Verifica se é possível gerar uma palavra a partir da palavra que ele me deu (rootWord)
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word { //Verifico cada letra da palavra que eu digitei
            if let pos = tempWord.firstIndex(of: letter) { //Verifico se encontro aquela letra dentro da string
                tempWord.remove(at: pos) //Removo a letra da minha string
            } else {
                return false
            }
        }
        
        return true
    }
    
    //Verifico se a palavra existe
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}
//    func loadFile() {
//        //Acha o arquivo
//        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
//            if let fileContents = try? String(contentsOf: fileURL) {
//                //Aqui a gente trata o arquivo como uma string
//            }
//        }
//    }
    
//    func test() {
//        let input = "a b c"
//        let letters = input.components(separatedBy: " ") //Isso aqui cria o array = ["a","b","c"]
//        let input = """
//a
//b
//c
//"""
//        let letters = input.components(separatedBy: "\n") //Cria o array = ["a","b","c"]
//        let letter = letters.randomElement() //Randomiza um elemento do array (caso não tenha elementos, ele retorna uma string opcional)
//
//        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines) //Remove parte da string, ou um elemento nela, nesse caso, os espaços em branco e novas linhas
//    }
//       //Verificando palavras com erros:
//        let word = "swift"
//        let checker = UITextChecker() //Serve para checar uma string
//
//        let range = NSRange(location: 0, length: word.utf16.count) //Serve para checar o quanto da sua string você quer checar, usar o utf16 serve para ajudar na contagem de caracteres especiais, tais como os emojis, a gente usa ele para que o Objective-C entenda o que está armazenado.
//        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en") //Serve para nos reportar aonde ele encontrou um erro na nossa string, passando o início da nossa string (range), o início dela, se deve terminar quando chegar ao fim (wrap) e a linguagem
//
//        let allGood = misspelledRange.location == NSNotFound //serve para checar se ouve erro ou não
        
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
