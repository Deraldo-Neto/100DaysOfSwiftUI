//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Deraldo on 31/05/22.
//

import SwiftUI

//No swiftUI usamos struct ao invés de func, o motivo é por serem mais simples e mais rápidas, devido ao número de iteraçõoes que são feitas, nas strcuts não bem menos, views são views no SwiftUI.
//A gente não consegue modificar o que está por trás da View, isso é impossível. Por trás do nosso ContentView temos o que é chamado de UIHostingController, que é a ponte entre o UIKit e o SwiftUI, entretando, se você tentar modifica-la, você vai ver que seu código não vai mais rodar, então, caso queiramos mudar nossa view, é simples, basta com que a nossa caixa, ou nosso text ocupe mais espaço na view.
//Não tente sair fora de sua ContentView, você não vai conseguir.

//CUSTOM MODIFIERS
//quando eu crio em formato de structs, eu posso adicionar propriedades
//struct Watermark: ViewModifier {
//    var text: String
//
//    func body(content: Content) -> some View {
//        ZStack(alignment: .bottomTrailing) {
//            content
//
//            Text(text)
//                .font(.caption)
//                .foregroundColor(.white)
//                .padding(5)
//                .background(.black)
//        }
//    }
//}

//quando eu crio extensions, eu não posso criar propriedades nem nada disso, só coisas mais simples
//extension View {
//    func watermarked(with text: String) -> some View {
//        modifier(Watermark(text: text))
//    }
//}
//
//
//struct Title: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.largeTitle)
//            .foregroundColor(.white)
//            .padding()
//            .background(.blue)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//    }
//}
//
//extension View {
//    func titleStyle() -> some View {
//        modifier(Title())
//    }
//}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleModifier() -> some View {
        modifier(TitleModifier())
    }
}

//CUSTOM CONTAINERS
//Nessa primeira linha, usamos GENERICS, que significa: você pode passar qualquer tipo de Content que você quiser, contanto que seja uma View, e depois do dois pontos significa que o GridStack é uma view
//struct GridStack<Content: View>: View {
//    let rows: Int
//    let columns: Int
//    @ViewBuilder let content: (Int, Int) -> Content //Isso é uma função que recebe dois inteiros e retorna um Content, colocar ele como @ViewBuilder faz com que eu consiga retornar duas views, por exemplo, uma imagem e um texto, sem eu precisar colocar essa imagem e esse texto em um VStack
//
//    var body: some View {
//        VStack {
//            ForEach(0..<rows, id: \.self) { row in
//                HStack {
//                    ForEach(0..<columns, id: \.self) { column in
//                        content(row,column)
//                    }
//                }
//            }
//        }
//    }
//}

struct ContentView: View {
    //Por que diabos o swift sempre retonar SOME view?
    //Bom, é some view nos dizemos "quero que retorne um objeto que seja uma View, mas não quero dizer qual" e então o swift encontra qual é e retorna
    //O que acontece, se você altera o some View para qualquer coisa, tipo Text, contanto que retorne teste, fica tudo certo, mas nos não conseguimos deixar o retorno com somente View, isso acontece por que o swift precisa saber que tipo de view, qual é toda a view, como ela é, imagina ter que ficar retornando ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>, iria ser um sofrimento só, então retornar some View, resolve nosso problema, ele vai saber que é uma view e vai nos retornar
    //Mas temos duas perguntas:
    //1. Como funciona o VStack, ele tá conforme um protocolo View, mas como ele preenche que tipo de conteúdo ele tem, se ele pode conter muitas coisas diferentes dentro dele? Por exempo, se eu coloco dois Text dentro dele, como ele retorna apenas uma view, sendo que se fosse sem o VStack ele iria me retornar duas?
    //Para isso, o swift cria para gente a que chamamos de TupleView, que contem essas duas views, então ele responde a pergunta "Que tipo de View é essa?" com: É uma TupleView, contendo duas views de Text.
    //E É EXATAMENTE POR ISSO QUE O SWIFT TEM O LIMITE DE 10 VIEWS, se vc olhar a documentação da TupleView, você vai ver que nela, ele possui 10 viariáveis no máximo, por trás dos panos ele faz uma TupleView.
    //2. O que acontece caso retornemos várias views? Como isso roda?
    //Nesse caso, a view aplica um atributo especial chamado ViewBuilder, que tem o efeito de envolver todas essas views em uma TupleView, de modo que, embora pareça que temos várias Views, elas são combinadas em uma TupleView.
    //@State private var useRedText = false
    
    //VIEWS AS PROPERTIES
    //Essa maneira é melhor que a de baixo, criamos uma propriede computada, mas devemos ser cautelosos, já que nesse caso, não é aplicado o atributo @ViewBuilder aqui, ou seja, ele não coloca dentro de uma TupleView.
//    var motto1: some View {
//        Text("Draco dormiens")
//    }
    //Essa maneira aqui não é a ideial, por que o Swift não nos permite criar uma propriedade que se refere a outra propriedade, pois isso causaria problemas quando o objeto fosse criado. Isso significa que tentar criar um TextField vinculado a uma propriedade local causará problemas.
//    let motto2 = Text("nunquam titilladus")
    
    //Caso queiramos enviar várias views, temos 3 opções:
    //Colocar em uma stack
//    var spells1: some View {
//        VStack {
//            Text("Lumos")
//            Text("Obliviate")
//        }
//    }
    
    //Colocar em um group, sem especificar que tipo de organização você quer, o que fica a critério em como você vai usa-los no seu código
//    var spells2: some View {
//        Group {
//            Text("Lumos")
//            Text("Obliviate")
//        }
//    }
    
    //Adicionando o atributo @ViewBuilder, o que acaba sendo a melhor opção, já que assim ela imita o funcionamento do nosso Body
//    @ViewBuilder var spells3: some View {
//        Text("Lumos")
//        Text("Obliviate")
//    }
    
    //VIEW COMPOSITION
//    struct CapsuleText: View {
//        var text: String
//        var body: some View {
//            Text(text)
//                .font(.largeTitle)
//                .padding()
//                .foregroundColor(.white)
//                .clipShape(Capsule())
//        }
//    }
    
    
    var body: some View {
        //DAY 24
        Text("Hello, world")
            .titleModifier()
        //CUSTOM CONTAINERS
//        GridStack(rows: 4, columns: 4) { row, col in
//                Image(systemName: "\(row * 4 + col).circle")
//                Text("R\(row) C\(col)")
//        }
        
        //CUSTOM MODIFIERS
//        Text("Hello, world")
//            //.modifier(Title())
//            .titleStyle()
        
//        Color.blue
//            .frame(width: 300, height: 200)
//            .watermarked(with: "Hacking with Swift")
        
        //VIEW COMPOSITION
//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//                .foregroundColor(.white)
//            CapsuleText(text: "Second")
//                .foregroundColor(.yellow)
//        }
        
//        Text("Hello, world!")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        Button("Hello, world") {
//            print(type(of: self.body)) //Isso printa o tipo
//        }
        //.background(.red)
        //.frame(width: 200, height: 200)
        //Nosso caso o tipo é:
        //ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>
        //Isso significa que é um ModifiedContent que dentro dele eu tenho outro ModifiedContent (que dentro dele eu tenho um botão com texto e um BackgroundStyleModifier) e uma FrameLayout
//        .frame(width: 200, height: 200)
//        .background(.red)
        //Agora observe isso, eu troquei a ordem, e o que aconteceu?! Mudou, agora toda a caixa do botão está preenchida com vermelho, e não só o texto
        //Para você chegar no resultado que vc quer, vc precisa saber a ordem que vc quer que as coisas executem, você tem que pensar que o Swift vai ler seus ModifiedContent um por vez, então se eu quero pintar e alterar o tamanho, primeiro ele pinta dps ele altera o tamanho, se eu quero primeiro aumentar o tamanho e depois pintar, eu preciso fazer o contrário. Olhe esse exemplo:
//        Text("Hello, world!")
//            .padding() //Da um padding no texto
//            .background(.red) //pinta tudo de vermelho
//            .padding() // da um padding no padding
//            .background(.blue) // pinta de azul
//            .padding() // da um padding no padding
//            .background(.green) // pinta de verde
//            .padding() //da um padding no padding
//            .background(.yellow) //pinta de amarelo
        
        //CONDITIONAL MODIFIER
//        Button("Hello, world") {
//            useRedText.toggle()
//        }
//        .foregroundColor(useRedText ? .red : .blue) //se useRedText é verdade, pinta de vermelho, se for falso, de azul
        
        //ENVIRONMENT MODIFIERS
//        VStack {
//            Text("Gryffindor")
//                .font(.largeTitle) //MAS, os child modifiers tem prioridade em cima dos modificadores pais
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//        }
//        .font(.title) //Se eu coloco aqui a font, é como se eu coloca-se em cada um dos Text
        //MAS CUIDADO, existem modificadores que são adicionados filhos e pais, e não são modificados, por exemplo, se eu colocar um blur no pai com valor 5, se eu coloco no filho com valor 0, ele fica com um blur de valor 5 no total
        
        //VIEWS AS PROPERTIES
//        VStack {
//            motto1
//                .foregroundColor(.red)
//            motto2
//                .foregroundColor(.blue)
//            spells1
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
