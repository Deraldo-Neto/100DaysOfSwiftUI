//Os protocolos deixa a gente definir propriedades e métodos que queremos usar, sem implementa-los, só dizendo "eles devem existir", como um blueprint:

import Darwin
protocol Vehicle { //Para definirmos um protocolo, é só colocar protocolo e o nome dele na frente
    //Aqui listamos todos os métodos e as propriedades que quisermos.
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int) //Observe que essas funções não tem body dentro, é assim pq o protocolo não permite, aqui só especificamos o nome, a entrada e a saída
}

//Com esse protocolo, eu consigo criar vários tipos, novas classes, novos structs, enums...

//Dizemos ao swift que esse Car pertence ao Vehicle, e com isso todos os métodos do Vehicle devem existir dentro do Car, exatamente da mesma maneira
struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km")
    }
    
    //Esse é novo, mas tudo bem, o Vehicle fala: Você tem que ter esses, o resto você faz do jeito que quiser
    func openSunroof(){
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km")
    }
}

func commute(distance: Int, using vehicle: Vehicle){
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)

//Mas note, e se eu apagar o Vehicle do Car? não fica a mesma coisa?
//Sim, a mesma coisa, funciona da mesma maneira.
//Mas se alterarmos o commute para ao invés de pegar o Car, pegar o Vehicle, fazemos com que qualquer protocolo que coloquemos, faça com que ele funcione sem erros.
//O Swift sabe qual pegar, e por isso, ele não emite erros


let bike = Bicycle()
commute(distance: 50, using: bike)

//Com isso podemos simplesmente falar: "Olha, não me importe qual você use, contanto que seja subclasse de Vehicle, e ai ao usarmos o Vehicle ao invés do Car, faz com que o código fique mais dinamico. Assim não necessariamente precisa ser um carro, pode ser apenas um derivado de Vehicle

//Com os protocolos, a gente tb pode definir se a propriedade é só de leitura ou escrita, ou ambos:

protocol Vehicle1 {
    var name: String {get}
    var currentPassagers: Int {get set}
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car1: Vehicle1 {
    let name = "Car"
    var currentPassagers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km")
    }
    
    //Esse é novo, mas tudo bem, o Vehicle fala: Você tem que ter esses, o resto você faz do jeito que quiser
    func openSunroof(){
        print("It's a nice day!")
    }
}

struct Bicycle1: Vehicle1 {
    let name = "Bicycle"
    var currentPassagers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km")
    }
}

func getTravelEstimates(using vehicles: [Vehicle1], distance: Int){
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

let car1 = Car1()
let bike1 = Bicycle1()
getTravelEstimates(using: [car1, bike1], distance: 150)

//Veja só como o protocolo é flexível, eu consegui passar um carro e uma bicicleta e ele não reclamou. Eu até consigo retornar um protocolo
//Eu consigo tb colocar uma classe dependente de vários protocolos:

protocol CanBeEletric {
    
}

struct Car2: Vehicle1, CanBeEletric {
    let name = "Car"
    var currentPassagers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km")
    }
    
    //Esse é novo, mas tudo bem, o Vehicle fala: Você tem que ter esses, o resto você faz do jeito que quiser
    func openSunroof(){
        print("It's a nice day!")
    }
}

//Tipo de retorno Opaque: É de extrema importancia e é sempre usado no SwiftUI


//Retorna de 1 a 6
func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

//Retorna True ou False
func getRandomBool() -> Bool {
    Bool.random()
}

//Ambos, utilizam um protocolo do swift chamado equatable, que significa que eles conseguem ser comparados

print(getRandomNumber() == getRandomNumber())

//Mas se eles utilizam o Equatable, pq eu não posso colocar eles no retorno? Essa é a chave para entender as Opaques
//primeiro, sim você pode retornar um protocolo, mas ele não consegue comparar pq ele pdoe ser qualquer tipode Equatable
//O retorno Opaque nos permite esconder informações no nosso código, mas não do compilador do swift.
//Isso significa que o compilador entende o que está sendo retornado.
//Vamos melhorar nosso código

//Retorna de 1 a 6
func getRandomNumber1() -> some Equatable { //Aqui a gente tá falando: Olha, ele é um Equatable, mas um tipo especial de Equatable, nesse caso, ele vai saber que é um inteiro
    Int.random(in: 1...6)
}

//Retorna True ou False
func getRandomBool1() -> some Equatable {
    Bool.random()
}

print(getRandomNumber1() == getRandomNumber1())

//Sabe o que isso nos permite? Se eu alterar a função do getRandomNumber para Double, ele vai continuar permitindo:
func getRandomNumber2() -> some Equatable {
    Double.random(in: 1...6)
}

//Agora se eu tivesse colocado:
//func getRandomNumber2() -> Int {
//    Double.random(in: 1...6)
//}
//Ele iria achar ruim, pq o retorno tá Inteiro, mas na função ele retorna um Double

//Assim se eu mudar de ideia, não tem problema.
//Mas a verdadeira vantagem aqui é que o swift sempre sabe qual o tipo de data ele vai retornar.
//Pensa, com isso você pode ter o retorno que quiser, não precisa ficar especificando, pode ser um inteiro, pode ser um double, não tem problema.

//Extensions:
import Cocoa
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed()
    }
    
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}
var quote = " The truth is rarely pure and never simple "
let trimmed = quote.trimmed()

//Observe que eu extendi a string e coloquei o método novo nela
//Vantagens do Extension:
//Complemento do código
//Organização do código
//Acesso interno

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""
print(lyrics.lines.count)


struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}
extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

//Note que eu posso fazer uma extension do init, isso faz com que eu possa ou não usar o readingHours.

//Protocol Extensions

extension Collection { //Serve para qualquer tipo de coleção, arrays, dicionários...
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

//Veja só, não foi necessário colocar a função sayHello, pq o extension cria uma função básica pra gente.
struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()

//CHECKPOINT 8

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agentSellingName: String { get set }
    
    func salesSummary()
}

extension Building {
    func salesSummary() {
        print("Hello, my name is \(agentSellingName), this build have \(rooms) rooms and it cost $\(cost) ")
    }
}

struct House: Building {
    let rooms = 2
    let cost = 300000
    var agentSellingName = "Robson"
}

struct Office: Building {
    let rooms = 4
    let cost = 1000000
    var agentSellingName = "Roberterson"
}

let house = House()
house.salesSummary()
