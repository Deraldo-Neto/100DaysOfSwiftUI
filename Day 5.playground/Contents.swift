//IF:
//if -> significa que vai checar alguma coisa
//condição -> condição que deve ser verificada
//se emitir verdade, executa o que está dentro do if
let score = 85

if score > 80 {
    print("Great Job!")
}

let speed = 88
let percentage = 85
var age = 18

if speed >= 88 {
    print("Where we're going, we don't need roads.")
}

//Esse não será impresso por que a condição é falsa
if percentage < 85 {
    print("Sorry, you failed the test.")
}

if age >= 18 {
    print("You are eligible to vote.")
}

let ourName = "Dave Lister"
let friendName = "Arnold Rimmer"

if ourName < friendName {
    print("It's \(ourName) vs \(friendName)")
}

//Letra D é maior que a letra A
if ourName > friendName {
    print("It's \(friendName) vs \(ourName)")
}

var numbers = [1,2,3]
numbers.append(4)

if numbers.count > 3 {
    numbers.remove(at: 0)
}

print(numbers)

//Iqualidade:
let country = "Canada"

if country == "Australia" {
    print("G'day!")
}

let name = "Taylor Swift"

if name != "Anonymous" {
    print("Welcome, \(name)")
}

var username = "taylorswift13"

if username == "" {
    username = "Anonymous"
}

//Esse acima é igual esse a baixo:
if username.count == 0 {
    username = "Anonymous"
}
//Mas essa opção ele conta tudo antes pra dps dar o resultado
//A opção a baixo verifica se está vazio, o que é mais eficiente:
if username.isEmpty == true {
    username = "Anonymous"
}
//Podemos simplificar ainda mais:
if username.isEmpty {
    username = "Anonymous"
}

print("Welcome, \(username)")

//MÚLTIPLAS CONDIÇÕES
//Posso colocar uma condição depois da outra sem problemas

age = 16

if age >= 18 {
    print("You can vote in the next election.")
}

if age < 18 {
    print("Sorry, you're too young to vote.")
}

//Colocar essas duas condições assim não é eficiente pois são excludentes e o swift precisa fazer as duas condições
//Mas usando o else fica mais eficiente e optimizado pq caso não seja maior ou igual a 18, já cai na condição de else, ou seja, caso a condição seja false, ele cai no else:
if age >= 18 {
    print("You can vote in the next election.")
} else {
    print("Sorry, you're too young to vote.")
}

//Também posso fazer uma condição mais complexa, o else if, ele checa o segundo caso o primeiro seja falso, exemplo:
//if a {
// CÓDIGO QUE RODA CASO a SEJA VERDADE
// } else if b {
// CÓDIGO QUE DEVE RODAR SE a É FALSO MAS b É VERDADEIRO
// else {
// CÓDIGO QUE DEVE RODAR CASO a E b SEJAM FALSOS
//}

//Consigo também fazer uma condição dentro da outra, o que faz com que ele só execute a condição dentro, caso a condiçõa de fora execute
let temp = 25

if temp > 20 {
    if temp < 30 {
        print("it's a nice day.")
    }
}

//Nesse caso, eu posso simplificar usando o "e" (&&)
if temp > 20 && temp < 30 {
    print("It's a nice day.")
}

//Também existe a condição de "ou" (||)
let userAge = 14
let hasParentalConsent = true

if age >= 18 || hasParentalConsent == true {
    print("You can buy the game!")
}

//Posso, é claro, usar enums em if:
enum TransportOption {
    case airplane,helicopter, bicycle, car, escooter
}

let transport = TransportOption.escooter

if transport == .airplane || transport == .helicopter {
    print("Let's fly!")
} else if transport == .bicycle {
    print("I hope there's a bike path...")
} else if transport == .car {
    print("Time to get stuck in traffic.")
} else {
    print("I'm going to hire a scooter now!")
}

//Não se esqueça, não é possível comparar, TIPOS DIFERENTES

//As vezes vários ifs fica difícil de ver e de entender ou fácil de errar, então usamos o:
//SWITCH
enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.snow

switch forecast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}
//No swift ele passa caso a caso, e o primeiro que tá true, ele executa e sai da condição de switch.
//Eu posso colocar uma condição de default, caso nenhuma delas execute

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
default:
    print("Who are you?")
}

//NÃO SE ESQUEÇA: o switch sempre roda na ORDEM!

//Caso vc queira que ele execute os o caso subsequente, é só vc usar o fallthrough
let day = 5
print("My true love gave to me...")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

//LEMBRANDO QUE: o switch não altera o impacto da performance do código

//TERNARY CONDITIONAL (Condição Ternária)
//O nome veio do fato de ter três dados de uma vez
//Ele nos deixar checar a condição e ter duas saidas direto, serve para resumir o código

age = 18
let canVote = age >= 18 ? "Yes" : "No"
//               W          T      F
//             What?       True   False
print(canVote)

//Posso ter uma condição ternária dentro de um print
let hour = 23
print(hour < 12 ? "It's before noon" : "It's after noon")

let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount)

enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = (theme == .dark) ? "black" : "white"
print(background)

