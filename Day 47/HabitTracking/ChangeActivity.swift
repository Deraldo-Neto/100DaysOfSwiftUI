//
//  ChangeActivity.swift
//  HabitTracking
//
//  Created by Deraldo on 01/09/22.
//

import SwiftUI

struct ChangeActivity: View {
    @ObservedObject var activities = HoldAactivity()
    @State var habit: Activity

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Change the description of the habit")) {
                    TextField("Description", text: $habit.description)
                }
                
                Section(header: Text("Change completed times")) {
                    Stepper("\(habit.completed) times", value: $habit.completed, step: 1)
                }
            }
            .navigationTitle("Change Habit")
            .toolbar {
                Button("Save") {
                    SaveHabit()
                }
            }
        }
    }
    func SaveHabit() {
        if let indexHabit = activities.habits.firstIndex(where: {$0.id == habit.id}) {
            activities.habits[indexHabit] = habit
        }
        
    }
}

struct ChangeActivity_Previews: PreviewProvider {
    static var previews: some View {
        ChangeActivity(activities: HoldAactivity(), habit: Activity(name: "", description: "", completed: 0))
    }
}
