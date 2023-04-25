import Darwin
func greetUser() {
    print("Hi there!")
}

greetUser()

//Eu consigo copiar uma função para uma variável no swift.

//Note que não tem os parentes, se eu coloco os parenteses, ele entende que eu preciso rodar a função e ai jogar o resultado dela na variável.
var greetCopy = greetUser
greetCopy()

//Nesse caso, eu crio a função diretamente na variável, não preciso criar uma função separada.
//Isso é o que chamamos de closures. Um pedaço de código, uma funcionalidade, em que podemos passar pra frente, como uma função, e podemos chama-la quando quiser
let sayHello = {
    print("Hi there")
}

sayHello()

//Mas e caso queiramos colocar um paramentro e um retorno?
//Temos que colocar dentro dos {} com um 'in', ele representa o fim dos parametros e do retorno e o início do corpo do closures
let sayHello2 = { (name: String) -> String in
    "Hi \(name)!"
}

//Vamos a um exemplo aqui relacionado ao primeiro exemplo de hoje
//Caso a queiramos colocar o tipo para o GreetCopy, como ele ficaria?
var greetCopy2: () -> Void = greetUser
//Mas o que isso significa?
//Bom, os () significa que a função não recebe nenhum paramentro
//Já o -> significa que estamos retornando um retorno daquela função
//Void significa nada, isso quer dizer que a função não retorna nada (NOTA: as vezes você pode ver Void(), o que significa a mesma coisa)

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

//Se fossemos copiar essa função, fariamos:
let data: (Int) -> String = getUserData
//Note que aqui, mesmo eu dando um apelido para o parametro, eu não usei, dar um nome para parametros externo não importam em closures, só em funções
let user = data(1989)
print(user)
//Veja só, aqui também não preciso passar o nome do parametro, só ele direto, pq é uma closure
sayHello2("Taylor")
//Em um closure nos não usamos o nome do parametro, apenas ele diretamente.

//Mas e se eu quiser passar uma função pra outra função?
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2:String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}
//Aqui, eu tenho a função .sorted, e eu passei pra ela uma cópia da função captainFirstSorted
//let  captainFirstTeam = team.sorted(by: captainFirstSorted)
//print(captainFirstTeam)

//Agora veja sua mente explodindo:
//Eu posso utilizar um enclosure direto dentro de uma função, ou seja, ao inves de copiar uma função pra dentro de uma função igual eu  fiz anteriormente, aqui vamos fazer  um closures direto dentro da função
let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
})
print(captainFirstTeam)

//O objetivo do um closures é armazenar funcionalidade, para sermos capazes de dizer "Aqui está um trabalho que eu quero que você faça, mas não necessariamente agora".
//Ou seja:
//1. Rodar códigos depois de um delay
//2. Rodar o código depois de ter acabado uma animação
//3. Rodar um código depois de fazer um download
//4. Rodar algum código após o usuário clicar em uma opção de um menu.
//Os Closures são capazes de armazenar funções dentro de uma única variável, e então armazenar em algum lugar, nos conseguimos até retorna-las de uma função e armazenar em algum outro lugar.
//Caso você queira retornar alguma coisa de um closure que não tenha parametro, basta fazer o seguinte:
let payment = { () -> Bool in
    print("Paying an anonymous person…")
    return true
}
//Então, pensando no exemplo de colocar a Suzanne na ordem, conseguimos fazer de várias e várias maneiras:
//1. Criando uma função e copiando ela para dentro da função sorted:
func captainFirstSorted1(name1: String, name2:String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}

let captainFirstTeam1 = team.sorted(by: captainFirstSorted1)
print(captainFirstTeam1)

//2. Criando um closure e usando ele na declaração
let captainFirstSorted2 = { (name1: String, name2:String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}

let captainFirstTeam2 = team.sorted(by: captainFirstSorted2)
print(captainFirstTeam2)

//3. Colocando esse closure diretamente na função sorted:
let captainFirstTeam3 = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
})
print(captainFirstTeam3)

//Sintaxe melhorada:

let captainFirstTeam4 = team.sorted(by: { (a: String, b: String) -> Bool in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
})
print(captainFirstTeam4)

//Podemos transformar isso, nisso:

let captainFirstTeam5 = team.sorted(by: { a, b in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
})

print(captainFirstTeam5)

//Nesse caso, onde temos uma função como o sorted que recebe um closures, podemos fazer ainda melhor, utilizando:
//trailing closures:
//O que significa que a gente manda embora o by e os parentes que o envolve:

let captainFirstTeam6 = team.sorted { a, b in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
}

print(captainFirstTeam6)

//Da pra gente fazer ainda melhor, não passando NENHUM paramento e utilizando os parametros padrões que o Swift nos fornece, os chamados shorthand parameter names, que é o dolar acompanhado de números:


let captainFirstTeam7 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    
    return $0 < $1
}

print(captainFirstTeam7)

//Nesse caso não é tão interessante pq fica confuso, mas em casos como:
let reverseTeam = team.sorted {
    return $0 > $1
}
//Esse método se torna bem mais útil
//E não se esqueça: Como aqui eu tenho só uma linha, eu nem preciso do return pq o swift já sabe, logo:
let reverseTeam1 = team.sorted { $0 > $1 }

//Mais exemplos:

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}

animate(duration: 3, animations: {
    print("Fade out the image")
})

//Ou:
animate(duration: 3) {
    print("Fade out the image")
}

//Funções como parametros:

//Aqui eu levo dois parametros: size que é um inteiro, e generator com o apelido de using que é uma função que não recebe parametros mas retorna um inteiro, e a função retorna um array de inteiros
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    
    return numbers
}

//E eu posso chamar desta maneira:
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

//Ou dessa, menos resumida:
func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

//Função que recebe 3 funções:

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}



//CHECKPOINT 5:
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter {
    if $0.isMultiple(of:2) {
        return false
    }
    return true
}.sorted {
    if $0 > $1 {
        return false
    }
    return true
}.map {
    print(String($0) + " is a lucky number")
}
