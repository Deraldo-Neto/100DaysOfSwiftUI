//FUNCTIONS
//A função é útil para reutilizar um código.
//Funções são pedaços de códigos que você separa do resto do seu programa e os nomeia para que você possa consultá-los facilmente.
//func: marca o início da função
//showWelcome: nome da função
//Os parênteses são usados nas funções, para cria-las ou chama-las
func showWelcome() {
    print("Welcome to my app!") //Corpo da função
}

showWelcome() //Chamando a função

//Mas o que os parênteses fazem? Eles servem para configurar nossa função, deixar ela mais flexivel
let number = 139

if number.isMultiple(of: 2) { //Função customizada
    print("Even")
} else {
    print("Odd")
}

let roll = Int.random(in: 1...20)

func printTimesTable(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) * \(number) is \(i * number))")
    }
}

//Aqui eu chamo a função e eu passo um PARAMETRO, o ponto de customização
printTimesTable(number: 5, end: 20)
//No swift eu preciso falar o que eu to passando, no caso aqui, o number, se vc tirar, ele fala que vc não tá sendo claro
//O Parametro é o placeholder e o argumento é o valor atual (actual value)
//A ordem dos parametros quand é chamado tem que ser igual a da função
//Os valores dentro da função são destruidos assim que ela é finalizada.

//Como retornar valores:
import Cocoa

let root = sqrt(169)
print(root)

//A função rollDice retorna um inteiro
func rollDice() -> Int {
    return Int.random(in: 1...6) //return é o que eu quero retornar
}

let result = rollDice()
print(result)

func same(first: String, second: String) -> Bool {
    first.sorted() == second.sorted() //Quando eu tenho apenas uma linha dentro de uma função no swift, eu não preciso da palavra return, ele implicitamente já sabe disso
}

print(same(first: "abc", second: "cba"))

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c = pythagoras(a: 3, b: 4)
print(c)

func sayHello() {
    return //Eu posso usar o return para sair da função imediatamente caso ela não tenha retorno
}

//Como retornar vários valores de uma função
//A melhor solução para isso são tuplas
func getUser() -> (firstName: String, lastName: String) { //Aqui está nossa tupla, ela é colocada entre parenteses
    (firstName: "Taylor", lastName: "Swift") //Aqui eu posso até resumir e colocar ("Taylor", "Swift") como retorno, por que o swift vai saber do que se trata pq ele da um "match" na informação
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")

//São muito similares a dicionarios, mas são diferentes:
//No caso do dicionário, o Swift não sabe se as chaves estão preenchidas com antecedência. Ou seja, pode gerar erros
//Com a tupla ele sabe muito bem que está lá.
//Nos acessamos o valor usando o nome da variável e a chavek da tupla, não umas strings, o que pode gerar erros.
//E os dicionários podem conter centenas de valores.

//Também existe a possibilidade de eu criar tuplas sem especificar as chaves:
func getUser2() -> (String, String) {
    ("Taylor", "Swift")
}

//Porem, nesse caso, para pegar as variáveis de retorno eu preciso utilizar 0,1,2....
let user2 = getUser2()
print("Name: \(user2.0) \(user2.1)")
//Nesse caso não existe problema igual tem no dicionário, pq eu sei que existe valor ali


//Eu consigo fazer com que o retono de uma tupla armazene em diferentes variáveis de uma vez só:
let (firstName, lastName) = getUser2()
print("Name: \(firstName) \(lastName)")

//Caso por exemplo eu não precise mais de um valor, eu posso fazer o seguinte:
let (firstName2, _) = getUser()
print("Name: \(firstName2)")

//Em Swift conseguimos omitir o nome do parametro de saída(ARGUMENTO) com o underscore na frente do nome do parametro de entrada(PARAMETRO)
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result2 = isUppercase(string)

//Eu consigo também colocar um nome para o parametro de saida(ARGUMENTO) e um nome para o parametro de entrada(PARAMETRO).
//Para isso basta colocar o nome do parametro de saída(ARGUMENTO) primeiro e depois o de entrada(PARAMETRO):
func printTimesTable2(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTable2(for: 5)
