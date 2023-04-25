//
//  ContentView.swift
//  WeSplit
//
//  Created by Deraldo on 18/05/22.
//

//Diz que quero usar toda a framework do SwiftUI
import SwiftUI
//A View protocol vem do Swift UI, e a struct ContentView herda ela
//Tudo o que é importado para a tela, é uma View
struct ContentView: View {
    //var tapCount = 0 //Não posso fazer isso por que a struct é criada como constante, ela é imutavel, e suas propriedades são imutáveis
    //@State private var tapCount = 0 //Isso faz com que contornemos a limitação da struct, sabemos que não conseguimos alterar as propriedades são fixas, mas adicionar State faz com que ele consiga ser modificado
    //@State private var name = ""
    let students = ["Harry", "Hermione", "Ron"] //FIXO, CONSTANTE
    @State private var selectedStudent = "Harry" //Esse altera
    //Retorna alguma coisa que seja uma View, o Swift vai descobrir o que é
    var body: some View {
        //State, ou estado, é tudo aquilo que está sendo executado naquele instante, o que a pessoa vê e o que ela interage naquele instante, é o estado, por exemplo, ele não pode clicar em continue caso ele não enre com seu nome.
        //Button("Tap Count: \(tapCount)") {
            //tapCount += 1
        //}
        //Form {
            //TextField("Enter your name", text: $name) //Aqui precisamos colocar o dolar na frente da variável para que o swift entenda que ele precisa ler o valor do name e altera-lo quando o usuário digitar (two way binding)
            //Text("Your name is \(name)") //Observe que ele vai atualizando na mesma hora
        //}
        //LOOPS:
        //Form {
            //ForEach(0..<100) {
                //Text("Row \($0)")
            //}
        //}
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) { //Mostra as opções para o usuário, ele tem um título,e um binding, o $selectedStudent
                    ForEach(students, id: \.self) { //Então um ForEach para passar por todos os estudantes, com um id, ele é necessário e o Swift precisa dele para indentificar cada estudante individualmente, e saber quando eles são alterados, quando eu coloco o \.self eu quero dizer: "Olha, a string por si só já é única", logo, se vc tiver repetições, vc pode ter problemas
                        Text($0)
                    }
                }
            }
        }
        //O NavigationView faz com que não seja possível ultrapassar a safe area
        //NavigationView {
            //Form são listas estáticas (como texto e imagens) em forma de scroll, ou seja, verticais, mas dentro dele eu posso ter interações, como campo de textos, botões, switches, etc.
            //O Form possui um limite de 10 elementos, caso passe, ele crasha, podemos evitar isso, colocando os elementos dentros de um group, pq ai é considerado que ele tem duas coisas dentro, não 10 ou mais
            //Form {
                //O Group não muda o formado em que é lido o nosso layout, ele é apenas uma forma de evitarmos erros
                //Group {
                    //Text("Hello, world!") //.padding() //Isso é um MODIFIER, ele modifica o texto
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                //}
                //Já o Section, ele coloca uma separação, um gap
                //Section {
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                    //Text("Hello, world!")
                //}
            //}
            //.navigationTitle("Swift UI") //Conseguimos colocar um modifier de título no nosso navigationView
            //.navigationBarTitleDisplayMode(.inline) //Podemos até altera-lo e coloca-lo no centro com uma fonte menor.
        //}

            
    }
}

//Essa struct serve só para debug, ela herda a PreviewProvider, o que tá do lado direito, é uma simulação
//OPTION+COMMAND+P é um atalho para o resume do PreviewProvider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

