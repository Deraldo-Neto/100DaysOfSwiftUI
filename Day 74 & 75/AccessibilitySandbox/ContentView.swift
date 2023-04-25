//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Deraldo on 09/01/23.
//

import SwiftUI

struct ContentView: View {
    //let pictures = [
    //    "ales-krivec-15949",
    //    "galina-n-189483",
    //    "kevin-horstmann-141705",
    //    "nicolas-tissot-335096"
    //]
    
    //let labels = [
    //    "Tulips",
    //    "Frozen tree buds",
    //    "Sunflowers",
    //    "Fireworks"
    //]
    
    //@State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var value = 10
    
    var body: some View {
        //Image(pictures[selectedPicture])
        //    .resizable()
        //    .scaledToFit()
        //    .onTapGesture {
        //        selectedPicture = Int.random(in: 0...3)
        //    }
        //    .accessibilityLabel(labels[selectedPicture]) //Aqui faz com que ele me fale o que é essa imagem
        //    .accessibilityAddTraits(.isButton) //Serve para falar o que é essa iamgem
        //    .accessibilityRemoveTraits(.isImage) //Serve para ele não me falar que é uma imagem
        
        
        
        
        
        //Image(decorative: "character") //O Decorative é para dizer que aquela imagem é apenas decorativa. Ele não vai ler o que é essa imagem
            //.accessibilityHidden(true) //Serve para não falar nada
        
        //VStack {
        //    Text("Your score is")
        //    Text("1000")
        //        .font(.title)
        //}
        //.accessibilityElement(children: .combine) //faz com que ele leia tudo junto, como uma informação só
        //.accessibilityElement(children: .ignore) //faz ele ignorar o VStack. caso eu não passe nenhum parametro, o parametro default é o children: .ignore
        //.accessibilityLabel("Your score is 1000") //faz ele ler esse texto no lugar do VStack já que ignorei ele em cima
        
        
        
        
        
        
        VStack {
            Text("Value: \(value)")
            
            Button("Increment") {
                value += 1
            }
            
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        } //Assim fala qual o valor que ele tá e se tá aumentando ou diminuindo
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
