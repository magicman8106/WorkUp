//
//  newWorkoutView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI

struct newWorkoutView : View {
    @StateObject var viewModel = WorkoutPresetViewModel()
    @State private var newExercise : Int = 0
    @State private var unsetExerciseList : [Exercise] = []
    @State private var workoutName : String = ""
    var body  : some View{
     
               
        TextField("Workout Name", text: $workoutName).multilineTextAlignment(.center)
            List{
                
                ForEach(0..<newExercise, id :\.self){
                    index in
                    NewExerciseView(exercise: $unsetExerciseList[index])
                    
                }
            }
        Button("Save Workout"){
            viewModel.addWorkoutPreset(newWorkoutPreset: Workout(title: workoutName, workoutId: "", exerciseList: unsetExerciseList))
        }
            Button("Add Exercise"){
                unsetExerciseList.append(Exercise(name: "", reps: 0, sets: 0, pr: 0))
                newExercise += 1
            }
        
    }
}
#Preview{
    RootView()
}
