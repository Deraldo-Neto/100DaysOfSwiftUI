//Colocando valores default para os parametros:

import Darwin
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.removeAll(keepingCapacity: true)
print(characters.count)

//LIDANDO COM ERROS
enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 { throw PasswordError.short }
    if password == "12345" { throw PasswordError.obvious }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
    
}

let string = "12345"

do {
    let result = try checkPassword(string) //Em algumas situações eu posso usar o try! Esse não precisa de do nem catch, o que significa que eu estou falando que essa função é segura, mas caso ela não seja, vai gerar erro!
    print("Password rating: \(result)")
} catch {
    print("There was an error.")
}

//Versão sem do catch:
//let result2 = try! checkPassword(string)
//print("Password rating: \(result2)")

//As vezes eu quero emitir mensagens de erro específicas, eu consigo da seguinte maneira:
do {
    let result3 = try checkPassword(string)
    print("Password rating: \(result3)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
//A gente é obrigado a usar o TRY para o swift saber que aquela função que a gente tá executando pode ocorrer erros.

//CHECKPOINT 4

enum sqrtError: Error {
    case outOfBounds, noRoot
}

func sqrtFunction(_ number: Int) throws {
    if number > 10000 || number < 1 { throw sqrtError.outOfBounds }
    for i in 1...100 {
        if i * i == number {
            print("A raíz do seu número é: \(i)")
            break
        } else if i == 100 {
            throw sqrtError.noRoot
        }
    }
}

do {
    try sqrtFunction(10001)
} catch sqrtError.outOfBounds {
    print("Seu número é menor que 1 ou maior que 10000")
} catch sqrtError.noRoot {
    print("Seu número não possui raiz")
} catch {
    print("Ocorreu um erro inesperado!")
}
