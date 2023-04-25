import Cocoa

//BOOLEANOS:
//Retorna verdadeiro ou falso sempre
//Para declarar um boleano, é simples:
let goodDogs = true
var gameOver = false

//Você ainda pode declarar um boleano com uma operação tipo:
let isMultiple = 120.isMultiple(of: 3)

//Eu posso alterar o tipo do boleano com a exclamação:
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated)
isAuthenticated = !isAuthenticated
print(isAuthenticated)

//Eu posso alterar entre verdadeiro ou falso usando o .toggle() também, exemplo:
gameOver.toggle() //Sim, ele altera o valor de gameOver, sim, é a mesma coisa da exclamação!
print(gameOver)

//JUNTAR STRINGS:
//Existem duas maneiras:
//1: Juntar com o +
//2: Usando interpolação
let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart

//Posso fazer diversas vezes e de diversos meios:
let people = "Haters"
let action = "hate"
let lyric = people + " gonna " + action
//Mas essa maneira não é tão eficiente, se fizermos algo tipo:
let luggageCode = "1" + "2" + "3" + "4" + "5"
//O que ele faz é ir juntando aos poucos e guardando em variáveis temporárioas:
//let luggageCode = "12" + "3" + "4" + "5"
//let luggageCode = "123" + "4" + "5"
//let luggageCode = "1234" + "5"
//let luggageCode = "12345"

//O Swift tem uma maneira mais inteligente de fazer isso, utilizando interpolação:
let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message)

//Com isso consigo até juntar double/int com essa interpolação, diferente de usando a soma que eu iria precisar fazer algo do tipo:
let number = 11
var missionMessage = "Apollo " + String(number) + " landed on the moon."

//Interpolando ficaria:
missionMessage = "Apollo \(number) landed on the moon."

//Consigo até efetuar operações utilizando a interpolação:
print("5 x 5 is \(5 * 5)")

//CHECKPOINT 1:

let tempCelcius = 32
let tempFahrenheit = (9 * tempCelcius / 5) + 32
print("A temperatura em graus Celcius eh: \(tempCelcius)")
print("A temperatura em graus Fahrenheit eh: \(tempFahrenheit)")
