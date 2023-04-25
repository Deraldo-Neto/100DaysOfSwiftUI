//
//  DataView.swift
//  HabitTracking
//
//  Created by Deraldo on 31/08/22.
//

import SwiftUI

struct DataView: View {
    @ObservedObject var activities = HoldAactivity()
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var completed = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name for the habit")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Description for the habit")) {
                    TextField("Description", text: $description)
                }
                
                Section(header: Text("Number of times you do the habit")) {
                    Stepper("\(completed) times", value: $completed, step: 1)
                }
                
                
            }
            .navigationTitle("Add Habit")
            .toolbar {
                Button("Save") {
                    let activity = Activity(name: name, description: description, completed: completed)
                    activities.habits.append(activity)
                    dismiss()
                }
            }
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(activities: HoldAactivity())
    }
}
