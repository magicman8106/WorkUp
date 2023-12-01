//
//  WorkoutCellView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI
struct WorkoutCollapsedCellView : View {
    let workout : Workout
    @State private var expandView  = false
    var body : some View {
        
        if(self.expandView)
        {
            WorkoutExpandedCellView(workout: workout).onTapGesture {
                self.expandView = false
            }
        } else {
            VStack{
                Button(action: {self.expandView=true}){
                    Text(workout.title)
                }
                
            }
        }
    }
}
    struct WorkoutExpandedCellView : View {
        let workout : Workout
        var body : some View {
            VStack{
                Text(String(workout.title))
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
            }.frame(height: 300)
        }
    }
