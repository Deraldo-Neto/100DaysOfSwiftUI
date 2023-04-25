import Cocoa
//Options são quando você por exemplo, tenta pegar uma informação que não existe:
let opposites = ["Mario":"Wario", "Luigi":"Waluigi"]
//let peachOpposite = opposites["Peach"]
//Note, se tentarmos pegar pelo opposites de "Peach", não vai dar em nada, pq não existe
//Optionals significa que a data pode estar presente ou pode não estar presente.
//Nesse caso, ele é presentado pelo "?"
//Mas o que escolher? Deixar com ponto de interrogação? ou deixar sem?
//Bom, o swift gosta que sejamos optimizados, logo o que mais vamos ver é:
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
//O que significa que: Ele vai ler a opção do dicionário "Mario", se a opção tiver valor, ele vai fazer um "unrap" ou sej,a pegar o valor do "Mario" e armazenar em marioOpposite, e então, ele vai entrar na condição if, e vai ver que a condição é verdade, e então vai imprimir o print, se não, ele só vai desconsiderar

var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}

//O valor nulo é extremamente importante, e pode ser usado com todos os tipos
var num: Int? = nil
var str: String? = nil
var arr1 = [Int]() //Array de inteiros vazio
var arr2: [Int]? = nil

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil

if let number = number {
    print(square(number: number))
}

//var bestScore: Int? = nil
//bestScore = 101
//if bestScore > 100 {
//    print("You got a high score!")
//} else {
//    print("Better luck next time.")
//}
//Veja só, o código acima pode dar problema, pq ele está comparando um número inteiro com um número opcional

//como fazer um unwrap das optionals com segurança:
func printSquare(of number: Int?) {
    //se número for vazio, ele vai imprimir o "Missing input" e vai retornar para sair do guard
    guard let number = number else {
        print("Missing input")
        return
    }
    print("\(number) x \(number) is \(number * number)")
}

//por exemplo, se temos:
//var myVar: Int? = 3
//if let unwrapped = myVar {
    //Essa condição só é executada caso exista valor em myVar
//}
//guard let unwrapped = myVar else { //checa se existe valor no myVar, se não, cai no else
    //Essa condição só é executada caso NÃO exista valor em myVar
//}

//o guard é feito para nos ajudar:
//O Swift requer que você use um retorno caso o guard falhe
//E se passar pelo check, ou seja, se unwrapping tem um valor, você consegue usa-lo após o código do guard finalizar
//Não se esqueça que o guard só é usado junto com uma optional, ou seja, tem que ter o ?

//Use if let se você quiser apenas fazer o unwrap para algumas opcionais, mas prefira usar o guard let se estiver verificando especificamente se as condições estão corretas antes de continuar.

func double(number: Int?) -> Int? {
    guard let number = number else {
        return nil
    }
    return number * 2
}
let input = 5
if let doubled = double(number: input) {
    print("\(input) doubled is \(doubled).")
}

//Existe uma terceira maneira de fazer um unwrap das optionals, o nil coalescing
//Nesse caso, se não exitir valor, ele devolve um valor padrão.
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"
//let new = captains["Serenity", default: "N/A"]

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author)


let input1 = ""
let number1 = Int(input1) ?? 0
print(number1)

let names = ["Arya", "Bran", "Robb", "Sansa"]
//Se existe valor opcional, unwrap e então coloque em uppercased, se não, coloque "No one"
let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

var book1: Book? = nil
//Se temos um livro, e o livro tiver um author, e se o author tiver uma primeira letra, coloque ela maiúscula, se não, coloque "A"
let author1 = book1?.author?.first?.uppercased() ?? "A"
print(author1)

//Como lidar com erros com optionals:
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

//Quando a gente não se importa com o erro, não importa o resultado, a gente pode usar o try? Por que se for verdade, o getUser nesse caso vai retornar uma string, se não, um nil, e ai ele só cai fora do if
if let user2 = try? getUser(id: 23) {
    print(("User: \(user2)"))
}

//Caso queiramos usar junto com nil coalesting, basta fazer dessa maneira:
let user3 = (try? getUser(id: 23)) ?? "Anonymous"
print(user3)

//CHECKPOINT 9:

func rand(_ intArr: [Int]?) -> Int { intArr?.randomElement() ?? Int.random(in: 1...100) }

