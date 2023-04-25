//Swift suporta duas maneiras para armazenar dados:
//var: Pode mudar com o tempo.
//let: Ele nunca muda, o swift nem deixa, é uma constante.
//É possível utilizar o ponto e virgula, mas são raras as ocasioes e só serve para caso queira usar uma linha ao lado da outra.
import Cocoa

var greeting = "Hello, playground"

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

//Sempre declare as variáveis separando as palavras com a inicial maiúscula.
//Sempre que possível, utilize let. Primeiro pra optimizar seu código, segundo para não alterar variáveis da qual vc não pode/deve
//As variáveis existem basicamente para armazenar dados. E no Swift temos var e let para evitar problemas, como podemos modificar
//O var quantas vezes quisermos, você perde um pouco do controle.
let managerName = "Michael Scott"
let dogBreed = "Samoyed"
let image = "brasil.jpg"
let meaningOfLife = "How may roads must a man walk down?"

//STRINGS:
//Strings começam e termina com aspas duplas.
//Você pode escrever o texto da maneira que você quiser, inclusive com emojis, caso queira usar as aspas duplas, basta usar \"
//Não existe tamanho para uma String.
//Existem restrições da qual você tem que ter um cuidado, por exemplo, você não pode quebrar uma linha com um 'in' no final dela nem um 'an'.
//Caso queira, você vai precisar utilizar aspas triplas, ou seja, uma multi-line string. Exemplo:
let movie = """
A day in
the life of an
Apple engineer
"""
//Observe que as aspas triplas estão em linhas SEPARADAS do texto.


//Eu consigo contar quantas letras possui uma variavel com o .count
print(managerName.count)

//Consigo, inclusive, até colocar isso em uma variável:
let managerNameLenght = managerName.count //Quero ler um dado, por isso não uso parenteses.
print(managerNameLenght)

//Também é possível deixar o texto em capslock:
print(managerName.uppercased()) //Quero que você faça algo para mim

//Também consigo saber se a string começa com determinada letra/palavra usando o .hasPrefix
print(dogBreed.hasPrefix("S"))

//Ou então se a string termina com a letra/palavra usando .hasSuffix
print(image.hasSuffix(".jpg"))

//Nunca se esqueça que o Swift é case sensitive.

//NÚMEROS:
//Em swift, conseguimos quebrar números com o underscore(_) para facilitar a visualização, ele ignora os underscore, logo a variável reallyBig e a ReallyBigSame são a mesma coisa:
let score = 10
let reallyBig = 100_000_000
let reallyBigSame = 1_00_0_00_000

//Eu posso declarar uma variável numérica utilizando outras variáveis:
let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2

//Também posso utilizar esses "atalhos" para agilizar:
var counter = 10
counter += 5
counter *= 2
counter -= 10
counter /= 2

//Eu consigo até saber se o número é multiplo de outro no Swift:
let number = 120
print(number.isMultiple(of: 3))
print(120.isMultiple(of: 3))

//Caso queira usar numeros quebrados, usamos pontos flutuantes
//O nome vem devido a forma complexa em que o computador armazena a informação, movendo o ponto decimal com base no tamanho do número
let numberBreak = 0.1 + 0.2 //isso é um double
print(numberBreak) //Observe que o resultado é 0.300000000....

//Lembre-se: Você não pode somar um inteiro com um double:
let a = 1 //INT
let b = 2.0 //DOUBLE
//let c = a + b não é possível, chamamos isso de Type Safety. Swift é uma linguage type-safe para evitarmos erros com nossos dados.
//Para fazermos essa soma, precisamos tratar b como um inteiro ou tratar a como um double
let cb = a + Int(b)
let ca = Double(a) + b

//Não podemos alterar o tipo de variável que temos, se a variável é declarada como uma string, ela não pode se tornar um int, por exemplo, ou se ela é um double, ela não pode virar um int

//Mas eu posso, por exemplo:
var rating = 5.0
rating *= 2
//Swift não altera o tipo do rating, só o multiplica.
