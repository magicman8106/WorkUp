//
//  WorkoutCellViewBuilder.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI

struct WorkoutCollapsedCellViewBuilder : View {
    let workoutId : String
    let userId : String
    @State private var workout : Workout? = nil
    
    var body : some View{
        ZStack{
            if let workout {
                WorkoutCollapsedCellView(workout : workout)
            }
        } .task{
            self.workout = try? await UserManager.shared.getWorkoutPreset(userId: userId, workoutId : workoutId)
        }
    }
}
struct WorkoutExpandedCellViewBuilder : View {
    let workoutId : String
    let userId : String
    @State private var workout : Workout? = nil
    
    var body : some View{
        ZStack{
            if let workout {
                WorkoutExpandedCellView(workout: workout)
            }
        } .task{
            self.workout = try? await UserManager.shared.getWorkoutPreset(userId: userId, workoutId : workoutId)
        }
    }
}
