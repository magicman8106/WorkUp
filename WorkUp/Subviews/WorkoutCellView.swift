//
//  WorkoutCellView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI
struct WorkoutCollapsedCellView : View {
    let workout : Workout
    var body : some View {
        VStack{
            Text(String(workout.title))
            
        }
    }
}
struct WorkoutExpandedCellView : View {
    let workout : Workout
    var body : some View {
        VStack{
            Text("Title" + String(workout.title))
            List{
                ForEach(workout.exerciseList, id : \.name) {
                    exercise in
                    VStack{
                        
                        Text("name: " + String(exercise.name))
                        Text("reps: " + String(exercise.reps))
                        Text("sets: " + String(exercise.sets))

                        Text("reps: " + String(exercise.pr))

                    }
                }
            }
        }
    }
}
