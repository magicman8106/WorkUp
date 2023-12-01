//
//  NewExerciseView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 12/1/23.
//

import SwiftUI
struct NewExerciseView : View {
    @Binding var exercise : Exercise
    var body : some View {
        VStack{
            HStack{
                Text("Name")
                TextField("Bicep Workout", text : $exercise.name)
            }
            HStack{
                Text("Sets")
                TextField("5", value: $exercise.sets, formatter: NumberFormatter())
            }
            HStack{
                Text("Reps")
                TextField("12", value: $exercise.reps, formatter: NumberFormatter())
            }
            HStack{
                Text("PR")
                TextField("120", value: $exercise.pr, formatter: NumberFormatter())
            }
            
        }
    }
}
#Preview{
    RootView()
}
