//Classes, outra maneira de criar datas.
//Tem coisas em comum com as structs.
//1. Você consegue criar com nomes
//2. Adicionar propriedades, métodos, ter controle de acesso e propriedades de observação
//3. Criar iniciadores diferente para configurar novas instancias
//Mas temos diferenças:
//1. Temos hierarquias, podemos colocar funcionalidades de uma classe em uma outra classe
//2. Swift não criar o initializer para as classes, é muito complicado. Então temos que criar nosso próprio initializer ou então definiar os valores das variáveis
//3. Se copiar uma classe, ambas as classes vão ter as mesmas informações da classe. Se muda em um, muda em outro.
//4. Ele chama pelo deinitializer para executar quando a cópia final é destruida, se eu tenho A e B, quando eu deleto ambos, é invocado o deinitializer para excluir os dados usados por A e B
//5. Classes estáticas pode ter variáveis alteradas.
 import Cocoa

class GameClass {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGameClass = GameClass()
newGameClass.score += 10

struct GameStruct {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGameStruct = GameStruct()
newGameStruct.score += 10

//Parece igual, certo? Mas as diferenças citadas acima, fazem toda a diferença.

//Herança:

class Employee {
    let hours: Int
    
    init(hours: Int){
        self.hours = hours
    }
}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

//Note que ambas as classes eu tenho um "Employee" na frente do nome da classe, e observe que com isso, eu consigo usar a propriedade hours

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)

robert.work()
joseph.work()

//Compartilhar propriedades, também quer dizer compartilhar métodos, e eu posso chamar dos filhos:

class Employee1 {
    let hours: Int
    
    init(hours: Int){
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer1: Employee1 {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager1: Employee1 {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let novall = Developer1(hours: 8)
novall.printSummary()

//Mas as coisas dão uma complicada quando queremos mudar um método herdado
//Para isso, precisamos usar o override.
//ah mas por que eu tenho que ficar usando override?!
//Bom, ele é bem útil para falar a verdade, se caso você usar quando não precisa, o swift vai te alertar um erro, isso faz com que evite que você acidentalmente mude comportamentos das classes parentes.
//Outro motivo é que caso você use quando não precisa por que a classe pai não declara o mesmo método, você vai receber um erro. Isso faz com que impeça você de digitar coisas erradas, como nomes ou parâmetros.

class Developer2: Employee1 {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours.")
    }
}

//Se temos certeza que uma classe não vai mais ser herdada pra ninguém, podemos usar o final:

final class Manager2: Employee1 {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

//Como adicionar initializers para classes:

class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool
    
    //Isso não pode ser feito, por que já existe a classe init dentro do Vehicle
    //init(isConvertible: Bool){
    //    self.isConvertible = isConvertible
    //}
    
    init(isElectric: Bool, isConvertible: Bool){
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

//Caso eu não coloque uma classe de inicialização no filho, ele herda a do pai.

//Como copiar classes:

//classes são tipo de referência, por isso compartilham os mesmos dados

class User {
    var username = "Anonymous"
    
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"

print(user1.username)
print(user2.username)
//Veja que é o mesmo nome!
//Caso eu queira uma cópia, mas que elas sejam independentes, eu uso essa função copy que eu criei, assim, não impacta o original:
var user3 = User()
var user4 = user3.copy()
user4.username = "Taylor"

print(user3.username)
print(user4.username)



class Ewok {
    var fluffinessPercentage = 100
}
var chirpa = Ewok()
var wicket = Ewok()
chirpa.fluffinessPercentage = 90
print(wicket.fluffinessPercentage)
print(chirpa.fluffinessPercentage)

//Nesse caso os valores são diferentes, claro, foi invocado uma nova classe.

//Deinitializer:
//1. não usam func
//2. não tem parametros nem retornam dados
//3. Roda quando a ultima cópia é destruida
//4. Nunca o invocamos
//5. Não tem nas structs

//Escopo é o que tá dentro de um {}

class User1 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {
        print("User \(id): I'm dead!")
    }
}

var users = [User1]()

for i in 1...3 {
    let user5 = User1(id: i)
    print("User \(user5.id): I'm in control!")
    users.append(user5)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

//Observe isso! Como existe agora outra referência aos ids, eles só são destruidos no final!

//Trabalhando com variáveis dentro de classes

class User10 {
    var name = "Paul"
}

let user10 = User10()
user10.name = "Taylor"
print(user10.name)

//Isso não deveria ser permitido, já que é um let, uma constante.
//O que acontece aqui é como se ele apontasse para outro lugar, pro novo usuário.

var userX = User10()
userX.name = "Taylor"
userX = User10()
print(userX.name)

//Observe aqui que eu consigo deixar o mesmo nome, por que eu joguei o User10 pra dentro do userX
//Mas se eu trocasse o userX pra um let, não iria dar certo.

//A classe eu APONTO pra um lugar, diferente das Structs, por isso as classes não precisam do mutating

//CHECKPOINT 7

class Animal {
    let legs: Int
    init(legs: Int){
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Au au!")
    }
    
}

class Corgi: Dog {
    override func speak() {
        print("Corgi says: Au au!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Poddle says: Au au!")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    func speak(){
        print("Miau!")
    }
    
    init(isTame: Bool, legs: Int){
        self.isTame = isTame
        super.init(legs: 4)
    }
}

class Persian: Cat {
    override func speak(){
        print("Persian says: Meow!!")
    }
}

class Lion: Cat {
    override func speak(){
        print("Lion says: Roar!")
    }
}
