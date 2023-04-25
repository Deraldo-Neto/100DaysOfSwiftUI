//
//  RecordsView.swift
//  RollTheDice
//
//  Created by Deraldo on 03/04/23.
//

import SwiftUI

struct RecordsView: View {
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDice")
    var results = [Result]()
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            results = try JSONDecoder().decode([Result].self, from: data)
        } catch {
            results = []
        }
    }
    
    var body: some View {
        List {
            ForEach(results) { result in
                VStack(alignment: .leading) {
                    Text(result.date.formatted(date: .long, time: .shortened))
                        .font(.title3)
                    HStack {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(result.dicesValues) { valueOfDice in
                                    DiceView(valueOfDice: valueOfDice.value, rotate: false)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
            .listRowBackground(Color(red:0.114, green: 0.110, blue: 0.898))
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
