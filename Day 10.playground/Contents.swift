//STRUCTS
//Sempre começa com letra maiúscula
struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()

//Observe que ambos os albums foram criados com a mesma estrutura, mas tem valores únicos, são albuns separados
//E é bem simples, quando eu digo red.title, quer dizer que eu quero o título do red, etc...
//As coisas ficam mais interessante quando existem valores dentro da sua struct que podem alterar

struct Employee {
    //Os nomes das variáveis dentro da structs são chamadas de Properties (propriedades), propriedades da struct, as propriedades da struct são as variáveis
    let name: String //Propertie
    //Note que aqui eu crie um valor default para o tempo de férias
    //Nota também que ele é um var, se fosse let, nunca poderia ser alterado
    var vacationRemaining = 14 //Propertie
    
    //Veja só, aqui eu preciso desse mutating, pq suponha que vc crie um Employee que seja let, como ele vai alterar a vacationRemaining?
    //Então, ele não vai, então para contornar isso, caso queiramos alterar valores dentro da nossa struct, temos que usar o mutating
    //Detalhe: a função dentro de uma struct, se chama MÉTODO
    mutating func takeVacation(days: Int){ //Método
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

//Mas agora existe uma restrição, caso eu declare uma struct Employee que seja let, não pode ser constante, tem que ser variável, o swift não via deixar eu chamar a função takeVacation
var archer = Employee(name: "Sterling Archer", vacationRemaining: 14) //Quando eu crio uma constante(let) ou uma variável(var) de uma struct, a chamamos de instance (instancia)
//E a chamada do Employee é chamada de initializer (inicializador), ele inicializa o primeiro valor
//Ele é chamado disso por que dentro do Swift ele cria uma função especial chamada init dentro da struct, por fora ele faz na verdade: var archer = Employee.init(name: "Sterling Archer", vacationRemaining: 14)
//Isso é o que chamamos de syntactic sugar, pq por trás dps panos o swift omite o init.
archer.takeVacation(days: 5)
print(archer.vacationRemaining)

//Quando a gente escreve tipo: Double(a), na verdade, estamos chamando uma struct, para fazer a conversão

//Note como não precisei usar o vacationRemaining
let kane = Employee(name:"Lana Kane")
let poovey = Employee(name: "Paw Poovey", vacationRemaining: 14)

//Mas... parando para pensar, structs são muito parecidas com as tuplas, qual a diferença?
//Bom, a diferença se dá que é como se as tuplas fossem structs anonimas.
//Mas então pq usar structs?!
//Pense, se elas são como se fosse structs anonimas, caso vc precisa usa-las várias vezes, todas as vezes vc teria que ficar declarando, e o que se torna algo como:
//func authenticate(_ user: User) { ... }
//func showProfile(for user: User) { ... }
//func signOut(_ user: User) { ... }
//vira algo tipo:
//func authenticate(_ user: (name: String, age: Int, city: String)) { ... }
//func showProfile(for user: (name: String, age: Int, city: String)) { ... }
//func signOut(_ user: (name: String, age: Int, city: String)) { ... }
//O que é bem mais complexo.
//Tente usar tuplas quando você quiser dois ou mais retornos de uma função, e tenha preferencia para a struct quando os dados são fixos e rotineiros.

//Outra pergunta:
//Qual a diferença entre função e método?
//A unica diferença entre eles é que o método é que o método pertence a um tipo, como structs, enums e classes e as funções não.
//Mas sendo um método, existe uma vantagem, você pode usar os tipos que existem dentro daquele tipo, igual no exemplo que foi usado o vacationRemaining


//Calculo dinamico com struct:
struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    //Veja só que a variável vacationRemaining foi calculado dinamicamente
    var vacationRemaining: Int {
            vacationAllocated - vacationTaken
    }
}

var archer2 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer2.vacationTaken += 4
print(archer2.vacationRemaining)
archer2.vacationTaken += 4
print(archer2.vacationRemaining)
//Observe que ele tem só mais 6 dias de férias, pq toda vez que a propriedade estiver pronta, ele executa dinamicamente essa variável.

//get e set
//basicamente, o que é lido e o que é escrito
//Note que na struct acima, a gente não consegue falar pra ele "Olha, eu tenho 5 dias sobrando de férias (vacationRemaining) [.vacationRemaining = 5], pq a gente não falou pro swift como fazer isso, então para resolvermos esse problema, precisamos definir o get e o set
struct Employee3 {
    let name: String
    var vacationAllocated = 14 //Propriedade armazenada
    var vacationTaken = 0 //Propriedade armazenada
    
    //Veja só que a variável vacationRemaining foi calculado dinamicamente
    var vacationRemaining: Int { //Propriedade computada
        //Código de leitura, toda vez que eu ler alguma coisa, é daqui que eu vou pegar.
        get {
            vacationAllocated - vacationTaken //Nessa caso então, quando eu chamo o vacationRemaining, ele vai me falar: "Olha, essa variável tem o valor definido como o vacationAllocated - vacationTaken"
        }
        //Código de escrita, toda vez que eu quiser escrever algo na vacationRemaining, é isso que é executado
        set {
            vacationAllocated = vacationTaken + newValue //newValue é feito pro set pelo swift, se falarmos que o VacationRemaining é 25, o newValue vai ser 25
            //O caso do set é parecido, quando eu falar: "Olha, eu tenho 5 dias de férias restante" [.vacationRemaining = 5] ele vai calcular: então de férias alocadas (ou dias disponíveis de férias) você tem o número de dias que você tirou (vacationTaken) mais o newValue, que é o número de dias de férias restante (vacationRemaining), um exemplo, se eu defino que eu tenho 14 dias de férias, e eu falo pra ele "Opa, tirei 4 dias de férias", ele vai saber que as férias restantes é, o número de dias de férias que vc tem menos o número de dias de férias que você tirou, logo, 10 dias restantes (vacationRemaining = 10). Agora se eu viro e falo: "Eu tenho 5 dias de férias restante" ele vai epgar o número de dias de férias que você tirou (nesse exemplo, 4 dias), e vai somar com o valor de férias restante qaue você disse que tinha (nesse caso, 5) dando um total de 4+5 = 9, resultando que a quantidade de férias alocada é 9
        }
    }
}
var archer3 = Employee3(name: "Sterling Archer", vacationAllocated: 14)
archer3.vacationTaken += 4 //Disse que tirei 4 dias
print(archer3.vacationAllocated) //Note que eu tenho alocado 14 dias de férias, mesmo tirando 4.
archer3.vacationRemaining = 5 //Disse que eu tenho 5 dias
print(archer3.vacationAllocated) //Note que aqui eu tenho 9 dias de férias, por que eu tirei 4 e somei com 5 que eu tinha sobrando.

struct Game {
    var score = 0
}

var game = Game()
game.score += 10
print("Score is now \(game.score)")
game.score -= 3
print("Score is now \(game.score)")
game.score += 1
//O não! Esqueci de printar o ultimo.

struct Game2 {
    var score = 0 {
        didSet {
            print("Score is now \(game.score)")
        }
    }
}

var game2 = Game2()
game.score += 10
game.score -= 3
game.score += 1
//Pronto, agora isso não acontece mais, todas as vezes em que o score for alterado, ele vai executar o código do print
//Detalhe que o Swift ainda nos dá uma variável dentro do didSet que é a oldValue que nos mostra qual o valor antigo
//Também existe o willSet, que nos mostra o que vai ser alterado.
//E é claro, o willSet nos temos o newValue, que mostra qual será o novo valor

struct App {
    var contact = [String]() {
        willSet {
            print("current value is: \(contact)")
            print("New value will be: \(newValue)")
        }
        
        didSet {
            print("There are now \(contact.count) contacts")
            print("Old value was: \(oldValue)")
        }
    }
}

var app = App()
app.contact.append("Adrian E")
app.contact.append("Allen W")
app.contact.append("Ish S")

//Custom initializers
struct Player {
    let name: String
    let number: Int
    
    //Note que o init não é uma função, ele não é iniciado por func, ele não tem nenhum tipo de retorno e ele tem um self
    init(name:String){
        self.name = name //Esse self.name está se referindo ao meu Player, eu posso colocar um apelido para o name para não precisar usar o self
        //Aqui se caso eu comento o number, ele vai achar ruim, pq se eu uso o init, eu tenho que dar o inicial para todos os meus parametros
        number = Int.random(in: 1...99)
    }
}

//Note que: let player = Player(name: "Megan R", number: 15), não funciona, por que eu já inicializei meu number no init
let player = Player(name:"Megan R")
print(player.number)

struct Country {
    var name: String
    var usesImperialMeasurements: Bool
    init(countryName: String) {
        name = countryName
        let imperialCountries = ["Liberia", "Myanmar", "USA"]
        if imperialCountries.contains(name) {
            usesImperialMeasurements = true
        } else {
            usesImperialMeasurements = false
        }
    }
}

//Note um exemplo errado:
struct Language {
    var nameEnglish: String
    var nameLocal: String
    var speakerCount: Int
    init(english: String, local: String, speakerCount: Int) {
        self.nameEnglish = english
        self.nameLocal = local
        self.speakerCount = speakerCount
    }
}
//let french = Language(nameEnglish: "French", nameLocal: "français", speakerCount: 220_000_000)
//Nesse caso, na hora de eu declarar a variável, eu coloquei o nameEnglish, mas como eutenho um init, deveria ser english

struct Cottage {
    var rooms: Int
    var rating = 5
    init(rooms: Int) {
        self.rooms = rooms
    }
}
let bailbrookHouse = Cottage(rooms: 4)
