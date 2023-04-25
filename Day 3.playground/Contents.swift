import Cocoa
import Foundation

var greeting = "Hello, playground"
//ARRAYS:
//É usado quando quero vários dados em um só lugar
//Ele pode ser ser bool, double, int, string...
//Fora que ele pode ser vazio ou quantas variáveis eu quiser
//Array de strings:
var beatles = ["John", "Paul", "George", "Ringo"]
//Array de inteiros:
let number = [4, 8, 15, 16, 23, 42]
//Array de doubles:
let temperatures = [4.2, 32.8, 42.4, 36.5]

//Temos indeces nos arrays, que começam com 0
print(beatles[0])
print(number[1])
print(temperatures[2])

//Eu posso adicionar um item ao array usando .append, ele vai pro final do array, e eu posso adicionar quantos eu quiser
beatles.append("Adrian")
beatles.append("Allen")
beatles.append("Novall")
beatles.append("Vivian")

//Mas, eu não posso adicionar tipos diferentes em variáveis, exemplo, não posso adicionar uma string em um array de decimais

//Dessa maneira eu crio um Array de inteiros, assim, ele DEVE ser de inteiros
//Os parenteses existem por que você pode customizar a maneira que você cria o array colocando informaçõa dentro deles
var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

//Array de strings
var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

//Existe outra maneira de declarar um Array, você pode colocar ele entre colchetes: var albums = Array<Strings>() é igual a albums = [Strings]()
//LEMBRE-SE: O Swift é type-safe e você SEMPRE deve indicar o que você está armazenando

//Mas, caso você declare armazenando, o Swift vai saber qual o tipo dele:
var albums2 = ["Folklore"]
albums2.append("Fearless")
albums2.append("Red")

//Eu também posso criar arrays dessa maneira:
var cities2: [String] = ["London", "Paris", "New York"]

//Você consegue saber quantos itens eu você tem em um array:
print(albums.count)

//Você também pode remover o item que você quiser do array:
var characters = ["Lana", "Pam", "Ray", "Sterling"]
characters.remove(at: 2)
print(characters.count)

//Ou ainda remover todos os itens:
characters.removeAll()
print(characters.count)

//Você também consegue saber se existe o item dentro do array:
let bondMovies = ["Casino Royale", "Spectre", "No Time to Die"]
print(bondMovies.contains("Frozen"))

//Também é possível colocar em ordem o Array com o .sorted()
let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())

//E você pode reverter um array:
let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)
//Porém, como você pode ver no print, ele imprime algo estranho, ele deixa o array original intacto e ele se lembra que aquilo tá revertido, ele faz isso por ser mais rápido

//DICIONARIOS:
//Podemos armazenar do jeito que a gente quiser, isso é bom para evitar indices e a gente pode definir a que aquele valor representa, sempre a esquerda a chave e a direita o valor, por exemplo:
let employee = [
    "name": "Talor Swift",
    "job": "Singer",
    "location":"Nashville"
]

print(employee["name"])
print(employee["job"])
print(employee["location"])

//Porem, dessa maneira que foi utilizada, como eu posso colocar qualquer valor de chave, pode ser que eu não tenha retorno de dados, por isso o alerta.
//Para evitar esse alerta, a gente pode colocar uma respota padrão, caso não exista valor:
let employee2 = [
    "name": "Talor Swift",
    "job": "Singer",
    "location":"Nashville"
]

print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])

//Detalhe que os dicionários podem ter qualquer tipo de chave e qualquer tipo de valor, exemplos:
let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false
]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2016, default: "Unknown"])

//Eu também posso fazer declaração de dicionários dessa maneira, observe que a chave é uma string e o valor um inteiro
var height = [String: Int]()
height["Yao Ming"] = 229
height["Shaquille O'Neal"] = 216
height["LeBron James"] = 206

//Eu posso também dar sobreescrever uma chave:
var archEnemies = [String: String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"
archEnemies["Batman"] = "Penguin"

//Não se esqueça: Swift é type-safe, você não pode alterar a chave ou o valor ao armazenar.

//Existe uma terceira maneira de armazenar Arrays no swift, o SET, ele é parecido com o Array, mas ele não lembra a ordem que você armazenou e ele remove duplicatas e é mais rápido para fazer buscas por não ter ordem
let actors = Set([
    "Denzel Washington",
    "Tom Cruise",
    "Nicolas Cage",
    "Samuel L Jackson"
])
print(actors) //Observe que a cada momento ele pode imprimir de forma aleatória

//Observe também que aqui eu não junto, eu INSIRO, pq não existe ordem
var actors2 = Set<String>()
actors2.insert("Denzel Washington")
actors2.insert("Tom Cruise")
actors2.insert("Nicolas Cage")
actors2.insert("Samuel L Jackson")

//ENUMS:
//Evita erros, deixa mais organizado e seguro
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

//Também pode ser declarado assim:

enum Weekdays {
    case monday, tuesday, wednesday, thursday, friday
}

//E resumido assim, já que ele sabe o que é o day:
var day2 = Weekday.monday
day2 = .tuesday
day2 = .friday

