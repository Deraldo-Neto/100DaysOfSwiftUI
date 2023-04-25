//
//  ContentView.swift
//  HabitTracking
//
//  Created by Deraldo on 30/08/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = HoldAactivity()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            Section {
                List {
                    ForEach(activities.habits) { habit in
                        NavigationLink {
                            ChangeActivity(activities: activities, habit: habit)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .font(.headline)
                                    
                                    Text(habit.description)
                                }
                                
                                Spacer()
                                
                                Text("\(habit.completed)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Habit-tracking")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label : {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddActivity) {
                    DataView(activities: activities)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
