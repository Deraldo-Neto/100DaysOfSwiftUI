struct BankAccount {
    var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)

let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

//Isso não deveria ser possível:
//account.funds -= 1000
//Para isso não ocorrer, devemos falar para o swift que a nossa propriedade funds deve ser disponível para leitura e escrita apenas dentro da struct
//para isso, é bem simples, basta adicionar private nos fundos

struct BankAccount1 {
    private var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}
//Isso se chama access control, ou controle de acesso.
//Já que não é possível acessar a propriedade fora da sua estrutura, quando eu digo que não é possível acessar a propriedade fora da sua struct, eu to falando que SÓ ELA PODE ACESSAR
//então pra colocar valor nela, vc ou tem que colocar em uma função, ou você tem que colocar no init
//Use private para que nada fora da estrutura use isso
//Use fileprivate para que nada fora desse arquivo use isso
//Use public pra qualquer um em qualquer lugar possa usar
//private(set) deixa qualquer um ler essa propriedade mas só deixe meu método escrever nele

struct BankAccount2 {
    //Eu colocar essa propriedade como private(set) faz eu parar de cometer erros, o swift vai forçar com que não se escreva funções de fora
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

struct School1 {
    var staffNames: [String]
    private var studentNames: [String]
    init(staff: String...) {
        self.staffNames = staff
        self.studentNames = [String]()
    }
}
let royalHigh = School1(staff: "Mrs Hughes")


//Static, como você pode ver, é como se vc colocasse esse valor como global, se eu altero um, altera todos
//Serve para dados comuns
struct School {
    static var studentCount = 0
    
    static func add(student:String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

School.add(student: "Taylor Swift")
print(School.studentCount)

//self = o valor atual da estrutura 55,"Hello", true
//Self = o tipo atual da estrutura Int, String, Bool

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

struct Employee {
    let username: String
    let password: String
    
    static let example = Employee(username: "Deraldo", password: "h4ir0frce0ne")
}


struct NewsStory {
    static var breakingNewsCount = 0
    static var regularNewsCount = 0
    var headline: String
    init(headline: String, isBreaking: Bool) {
        self.headline = headline
        if isBreaking {
            NewsStory.breakingNewsCount += 1
        } else {
            NewsStory.regularNewsCount += 1
        }
    }
}

//struct Person {
//static var population = 0
//var name: String
//init(personName: String) {
//    name = personName
//    population += 1
//}
//}
//Exemplo de algo que não da certo, precisa colocar Person.population


//CHECKPOINT 6

struct Car {
    let model: String
    private let seats: Int
    static var gear = 0
    
    init(model: String, seats: Int, gear: Int){
        self.model = model
        self.seats = seats
        Car.gear = gear
    }
    
    static func gear_up_down(gear: Int){
        if gear >= 1 && gear <= 10{
            Car.gear = gear
            print("Atual gear: \(gear)")
        } else {
            print("Invalid gear!")
        }
    }
}

Car.gear_up_down(gear: 2)

//Usando private

struct Car1 {
    let model: String
    private let seats: Int
    private(set) var gear = 0
    
    init(model: String, seats: Int){
        self.model = model
        self.seats = seats
    }
    
     mutating func gear_up_down(gear: Int){
        if gear >= 1 && gear <= 10{
            self.gear = gear
            print("Atual gear: \(gear)")
        } else {
            print("Invalid gear!")
        }
    }
}

var carro = Car1(model: "Corsa", seats: 5)
carro.gear_up_down(gear: 3)
