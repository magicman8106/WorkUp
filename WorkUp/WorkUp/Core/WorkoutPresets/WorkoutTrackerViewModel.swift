//
//  WorkoutTrackerViewModel.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import Foundation
import SwiftUI
import Combine
import SwiftUI
struct TrackedWorkout : Codable{
    let title : String
    let workoutId : String
    let exerciseList : [Exercise]
    let workoutDate : Date
    
    init(title : String, workoutId : String, exerciseList : [Exercise] , workoutDate : Date){
        self.title = title
        self.workoutId = workoutId
        self.exerciseList = exerciseList
        self.workoutDate = workoutDate
    }
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case workoutId = "workout_id"
        case exerciseList = "exercise_list"
        case workoutDate = "workout_date"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.exerciseList = try container.decode([Exercise].self, forKey: .exerciseList)
        self.workoutDate = try container.decode(Date.self, forKey: .workoutDate)
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.workoutId, forKey: .workoutId)
        try container.encode(self.exerciseList, forKey: .exerciseList)
        try container.encode(self.workoutDate, forKey: .workoutDate)
    }
    
}

@MainActor
final class WorkoutTrackerViewModel : ObservableObject {
    @Published private(set) var trackedWorkouts : [TrackedWorkout] = []
    func getTrackedWorkouts(){
        Task{
            do{
                let authDataResults = try AuthenticationManager.shared.getAuthenticatedUser()
                self.trackedWorkouts = try await UserManager.shared.getAllTrackedWorkouts(userId : authDataResults.uid)
                
            } catch{
                print("error \(error)")
            }
        }
    }
    func updateTrackedWorkouts(updatedTrackedWorkout : TrackedWorkout) async throws {
        Task{
            do{
                let authDataResults = try AuthenticationManager.shared.getAuthenticatedUser()
                try await UserManager.shared.updateTrackedWorkout(userId: authDataResults.uid, updatedTrackedWorkout: updatedTrackedWorkout)
                getTrackedWorkouts()
            } catch{
                print("error \(error)")
            }
        }
    }
    func addTrackedWorkout(newTrackedWorkout : TrackedWorkout) async throws {
        Task {
            do{
                let authDataResults = try AuthenticationManager.shared.getAuthenticatedUser()
                try await UserManager.shared.addTrackedWorkout(userId: authDataResults.uid, newTrackedWorkout: newTrackedWorkout)
                getTrackedWorkouts()
            }
        }
    }
}
