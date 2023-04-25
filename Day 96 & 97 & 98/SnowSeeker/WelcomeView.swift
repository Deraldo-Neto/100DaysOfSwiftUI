//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Deraldo on 11/04/23.
//

import SwiftUI

struct WelcomeView: View { //View usada para contornar o problema de visualização de telas maiores
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
