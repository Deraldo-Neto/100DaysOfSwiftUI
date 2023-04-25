//FUNDAMENTOS DO SWIFT
import Cocoa
import Darwin
import Foundation

//Constantes e Variáveis:
//Variáveis podem ser alteradas
var name = "Ted"
name = "Rebecca"
//Constantes não
let user = "Daphne"
//Print para imprimir na tela
print(user)
//Strings são entre aspas duplas
let actor = "Tom Cruise"
//Você consegue colocar aspas duplas colocando uma barra antes
let quote = "He tapped a sing saying \"Believe\" and walked away."
//Você consegue colocar textos em múltiplas linhas com três aspas duplas
let movie = """
A day in
the life of an
Apple engineer
"""
//Não importa como você fez sua string, o swift te da uma coleção de propriedades e métodos para você trabalhar copm ele
print(actor.count)
print(quote.hasPrefix("He"))
print(quote.hasSuffix("away."))

//Números inteiros (Int)
//Você pode declarar um valor e usa-lo para armazenar em outras variáveis
let score = 10
let higherScore = score + 10
let halvedScore = score / 2
//Você pode alterar um valor direto
var counter = 10
counter += 5
//Os números inteiros também tem suas próprias funcionalidades
let number = 120
print(number.isMultiple(of: 3)) //Se é multiplo de 3
//Posso criar um número aleatório
let id = Int.random(in: 1...100)

//Números decimais (Double)
let score2 = 3.0 //Aqui eu declarei um double, note que ele é tratado de forma diferente de um inteiro, você não pode mistura-los

//Booleanos
let goodDogs = true
let gameOver = false
//Você pode alterar o valor do boleano
var isSaved = false
isSaved.toggle()

//Interpolação de strings
let name2 = "Taylor"
let age = 26
let message = "I'm \(name) and I'm \(age) years old"

//Arrays
var colors = ["Red", "Green", "Blue"]
let numbers = [4, 8, 15, 16]
var readings = [0.1, 0.5, 0.8]
//Ao utilizar o array, muito cuidado para utilizar um array válido
print(colors[0])
print(readings[2])
//Posso agrupar um array, contanto que seja do mesmo tipo do array utilizado
colors.append("Tartan")
//consigo contar arrays ou remover no index que eu quiser
colors.remove(at: 0)
print(colors.count)
//Consigo verificar se existe o item dentro do array
print(colors.contains("Octarine"))

//Dicionários
//Consigo armazenar multiplos valores com uma chave de especificiação
let employee = [
    "name": "Taylor",
    "job": "Singer"
]
//Posso colocar um valor default para meu dicionário caso não exista
print(employee["job", default: "Unknown"])

//Sets
//Sets são similares aos arrays com 2 diferenças, eles não armazenam valores repetidos e não armazenam na ordem
var numbers2 = Set([1, 1, 3, 5, 7, 9])
print(numbers) //repetições são descartadas e os valores são dados em ordem aleatórias
//utilizo insert para inserir e não append pq não existe ordem
numbers2.insert(10)
//Tem vantagens em cima do array, ele roda mais rápido
numbers.contains(11)

//Enums
//Valores que eu posso usar pra fazer nosso código mais seguro e eficiente
enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}
var day = Weekday.monday
day = .friday

//Tipos de anotação
//Consigo forçar uma variável/constante a ter aquele tipo
var score3: Double = 0
let player: String = "Roy"
let luckyNumber: Int = 13
let pi: Double = 3.141
var isEnabled: Bool = true
var albums: Array<String> = ["Red", "Fearless"]
//Que consigo resumir para:
var albumsResume: [String] = ["Red", "Fearless"]
var user3: Dictionary<String,String> = ["id": "xderaldoneto"]
//Que consigo resumir para:
var userResume: [String: String] = ["id": "xderaldoneto"]
var books: Set<String> = Set(["The Bluest Eye", "Foundation"])
//Coleções vazias:
var teams: [String] = [String]()
//Posso remover o tipo de anotação
var clues = [String]()
//Enums tem o mesmo tipo do enum
enum UIStyle {
    case light, dark
}
var style: UIStyle = .dark

//if, elseif e else
//Serve para verificar condições
let age2 = 16
if age2 < 12 {
    print("You can't vote.")
} else if age2 < 18 {
    print("You can vote soon.")
} else {
    print("You can vote now.")
}
let temp = 26
//Condição E (ambos tem que ser verdade)
if temp > 20 && temp < 30 {
    print("It's a nice day.")
}
//Condição OU (um deles tem que ser verdade)
if temp > 20 || temp < 30 {
    print("It's a nice day.")
}

//Multiplas condições com switch
switch day {
case .monday:
    print("Oh shit! Here we go again...")
case .friday:
    print("SEXTOU")
default:
    print("Another day...")
}

//Condição ternária
//Verifica a condição e retorna uma coisa ou outra dependendo da condição
let canVote = age >= 18 ? "Yes" : "No"

//For
let plataforms = ["iOS", "macOS", "tvOS", "watchOS"]
//Consigo rodar por todos os elementos de um array
for os in plataforms {
    print("Swift works on \(os)")
}
//Ou por um range de números
for i in 1...12 { //de 1 a 12 incluindo o 12, se quiser de 1 até 12, deve ser 1..<12.
    print("5 x \(i) is \(5 * i)")
}
//Se quiser ignorar a variável do loop, você tem que declara-la com _
var lyric = "Haters gonna"
for _ in 1...5 {
    lyric += " hate"
}
print(lyric)
//While
var count = 10
while count > 0 {
    print("\(count)...")
    count -= 1
}
print("Go!")
//Consigo utilizar o continue para pular uma particularidade do loop e ir para a próxima iteração
let files = ["me.jpg","work.txt","sophie.jpg"]
for file in files {
    if file.hasSuffix(".jpg") == false {
        continue
    }
    
    print("Found picture: \(file)")
}
//Também posso utilizar o break sair fora do loop

//Funções
//Função sem retorno mas com parâmetro
func printTimesTable(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTable(number: 8)
//Função com retorno mas sem parâmetro
func rollDice() -> Int {
    Int.random(in: 1...6) //Se a função tiver apenas uma única linha, não é necessário o return
}
let result = rollDice()
print(result)

//Tuplas
//São convenientes para ter vários retornos de uma função
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}
let user2 = getUser()
print("Name: \(user2.firstName) \(user2.lastName)")
//Se eu não precisar de todos os valores da tupla, eu posso o _
let (firstName, _) = getUser()
print("Name: \(firstName)")

//Se eu não quiser passar o nome do parametro, eu posso colocar um _ antes
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}
let string = "HELLO WORLD"
let result2 = isUppercase(string)
//Alternativamente, eu posso colocar um segundo nome depois do nome, um para uso externo, e outro para uso interno
func printTimesTableEx(for number: Int) { //Number é usado de forma interna
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}
//For é usado de forma externa
printTimesTableEx(for: 5)

//Eu consigo colocar um valor default para um parametro
func greet(_ person: String, formal: Bool = false){
    if formal {
        print("Welcome. \(person)")
    } else {
        print("Hi, \(person)")
    }
}

//Na hora de declarar eu nem preciso passa-lo pq já existe um valor default
greet("Tim", formal: true)
greet("Taylor")

//ERROS
enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.obvious
    }
    
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 10 {
        return "OK"
    } else {
        return "Good"
    }
}

//Aqui eu: tento usar a senha 12345, se a senha não gerar erro, ela é armazenada no result3 e printa o result
//Se for ruim, ele cai no catch
do {
    let result3 = try checkPassword("12345")
    print("Rating: \(result3)")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch { //Esse é o erro genérico, ele vai pegar qualquer erro que der caso não encontre o erro preciso
    print("There was an error.")
}

//Closures
let sayHello = { (name: String) -> String in
    "Hi \(name)!"
}

let team = ["Gloria", "Suzanne", "Tiffany", "Tasha"]
let onlyT = team.filter({(name:String) -> Bool in
    return name.hasPrefix("T")
})
//Posso usar os cloures para deixar as coisas mais faceis:
print(onlyT)

//Posso ainda resumir esse closure
let onlyT2 = team.filter { $0.hasPrefix("T") }

//Structs
struct Album {
    let title: String
    let artist: String
    var isRelesed = true
    
    func printSummary() {
        print("\(title) by \(artist)")
    }
    
    //método que muda uma das suas propriedades
    mutating func removeFromSale() {
        isRelesed = false
    }
}

let red = Album(title: "Red", artist: "Taylor Swift")
print(red.title)
red.printSummary()

struct Employee2 {
    let name: String
    var vacationAllowed = 14
    var vacationTaken = 0
    
    //Calculo dinamico
    var vacationRemaining: Int {
        get {
            vacationAllowed - vacationTaken
        }
        
        set {
            vacationTaken = vacationTaken + newValue //newValue é o valor dado pelo swift, que é armazenado nessa variável quando a função é invocada
        }
    }
}

struct Game {
    var score = 0 {
        //Toda vez que eu modificar o valor do score, ele vai executar o didSet logo após
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3

//Temos uma struct especial que roda quando uan nova instancia é criada, o initializer
struct Player2 {
    let name: String
    let number: Int
    
    init(name: String){
        self.name = name
        number = Int.random(in: 1...99)
    }
}

//Controle de acesso nas structs
struct BankAccount {
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount(funds: 100)
print(account.funds)
//account.funds += 1000 Isso passa a ser impossível

//Static struct é útil para informações fixas
struct AppData {
    static let version = "1.3 beta 2"
    static let settingsFile = "settings.json"
}
print(AppData.version)

//Herança
class Employee3 {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer: Employee3 {
    func work() {
        print("I'm coding for \(hours) hours a day.")
    }
    
    //Caso eu queria substituir métodos da classe pai:
    override func printSummary() {
        print("I spend \(hours) hours a day fighting over tabs vs spaces.")
    }
}

let novall = Developer(hours: 8)
novall.work()
novall.printSummary()

class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

class Actor {
    var name = "Nicolas Cage"
}

var actor1 = Actor()
var actor2 = actor1

actor2.name = "Tom Cruise"
print(actor1.name)
print(actor2.name)

class Site {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("Site \(id): I've been created")
    }
    
    //Faço essas informações quando a classe é destruida
    deinit {
        print("Site \(id): I've been destroyed!")
    }
}

for i in 1...3 {
    let site = Site(id: i)
    print("Site \(site.id): I'm in control!")
}

//Eu posso alterar uma propriedade dde uma classe mesmo a classe sendo declarada como constante, nem precisa de mutating pra alterar.
class Singer {
    var name = "Adele"
}

let singer = Singer()
singer.name = "Justin"
print(singer.name)

//Protocolos
//Servem para dizer o mínimo que uma struct deve ter
protocol Vehicle2 {
    var name: String {get}
    var currentPassengers: Int {get set}
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car2: Vehicle2 {
    let name = "Car"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km")
    }
    
    func openSunroof() {
        print("It's a nice day")
    }
}

//Assim eu posso façar uma struct pra dentro de uma função
func commute(distance: Int, using vehicle2: Vehicle2) {
    if vehicle2.estimateTime(for: distance) > 100 {
        print("Too slow!")
    } else {
        vehicle2.travel(distance: distance)
    }
}

let car3 = Car2()
commute(distance: 100, using: car3)

//extensions
//serve para alterar alguma função
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed()
    }
    //Posso até adicionar novos clousures
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}
var quote2 = "   The truth is rarely pure and never simple   "
quote2.trimmed()

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
"""

print(lyric.lines.count)

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

//Optionals
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]
//O oposto da Peach pode existir ou pode não existir
let peachOpposite = opposites["Peach"]

//Se existir o posoto de Mario, printa
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

func printSquare(of number: Int?) {
    //Se number não exitir, ele cai fora da função
    guard let number = number else {
        print("Missing input")
        return
    }
    
    print("\(number) x \(number) is \(number * number)")
}

//Outra maneira de fazer optionals
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "Nome"

let input = ""
let number4 = Int(input) ?? 0
print(number4)

let names = ["Arya", "Bran", "Robb", "Sense"]
let chosen = names.randomElement()?.uppercased()
print("Next in line: \(chosen ?? "No one")")

enum UserError: Error {
    case badID, networkFailed
}
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}
//Tenta pegar o usuário, nesse caso, não importa o erro que dá, caso eu queira saber o erro, preciso usar o do e o catch
if let user = try? getUser(id: 23) {
    print("User: \(user)")
}
