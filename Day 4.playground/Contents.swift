import Cocoa

var greeting = "Hello, playground"
//As anotações servem basicamente para:
//1. O Swift não consegue adivinhar qual o tipo que deve ser usado
//2. Você quer que ele use um tipo diferente do seu default (por exemplo, eu quero que seja um Double, mas não quero toda hora ter que ficar digitando o .0)
//3. Você ainda não quer definir o valor
let surname: String = "Lasso"
var score: Int = 0
let pi: Double = 3.141
var isAuthenticated: Bool = true
var albums: [String] = ["Red", "Fearless"]
var user: [String: String] = ["id": "@twostraws"]
var books: Set<String> = Set([
    "The Bluest Eye",
    "Foundation",
    "Girl, Woman, Other"
])

//As annotations aqui não são necessárias, você consegue muito bem declarar sem ela
var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"]
var teams: [String] = [String]() //Aqui os parenteses é caso vc queira customizar o Array
var cities: [String] = []
var clues = [String]()
//Todas essas opções geram o mesmo resultado na prática, tanto faz qual você quer usar

//Enuns já são diferentes:

enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light
style = .dark //Posso fazer isso pq ele sabe o tipo que é style, ou seja UIStyle, ele já sabe disso

//Eu poderia escrever:
var style2: UIStyle = UIStyle.light
style2 = .dark
//Que da na mesma

//Mas se as annotations são opcionais, quando usa-las?
//Caso eu ainda não tenha decidido qual vai ser o tipo do constante, e o Swift precisa garantir que não usemos a constante antes dela ter um valor, exemplo:
let username: String
//CÓGIDOS COMPLEXOS
username = "@twostraws"
//MAIS CÓDIGO
print(username)
//Então esse tipo de código precisa da anotação, por que o swift não faz ideia de que tipo de data a variável é.

//CHECKPOINT 2:
let names = ["Ryu", "Ken", "Bison", "Guile", "Sakura", "Ryu"]
let namesUnique = Set(names)
print("Existem \(names.count) elementos no array, sendo \(namesUnique.count) únicos")
