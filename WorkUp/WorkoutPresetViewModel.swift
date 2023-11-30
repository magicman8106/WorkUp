//
//  WorkoutPresetViewModel.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import Foundation
import SwiftUI
import Combine
import SwiftUI
struct Exercise : Codable {
    var name : String
    var reps : Int
    var sets : Int
    var pr : Int
    init(name: String, reps : Int, sets : Int, pr : Int){
        self.name = name
        self.reps = reps
        self.sets = sets
        self.pr = pr
    }
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case reps = "reps"
        case sets = "sets"
        case pr = "pr"
    }
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.reps = try container.decode(Int.self , forKey: .reps)
        self.sets = try container.decode(Int.self, forKey: .sets)
        self.pr = try container.decode(Int.self, forKey:.pr)
    }
    func encode(to encoder : Encoder ) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.reps, forKey: .reps)
        try container.encode(self.sets, forKey: .sets)
        try container.encode(self.pr, forKey: .pr)
    }
}
struct Workout : Codable {
    var title : String
    var workoutId : String
    var exerciseList : [Exercise]
    init(title : String, workoutId : String, exerciseList : [Exercise])
    {
        self.title = title
        self.workoutId = workoutId
        self.exerciseList = exerciseList
    }
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case workoutId = "workout_id"
        case exerciseList = "exercise_list"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.workoutId = try container.decode(String.self, forKey: .workoutId)
        self.exerciseList = try container.decode([Exercise].self, forKey: .exerciseList)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.workoutId, forKey: .workoutId)
        try container.encode(self.exerciseList, forKey: .exerciseList)
    }
}

@MainActor
final class WorkoutPresetViewModel : ObservableObject {
    @Published var workoutPresets : [Workout] = []
    
    func getWorkoutPresets(){
        Task{
            do{
                let authDataResults = try AuthenticationManager.shared.getAuthenticatedUser()
                self.workoutPresets = try await UserManager.shared.getAllWorkoutPresets(userId : authDataResults.uid)
                
            } catch{
                print("error \(error)")
            }
        }
    }
    func updateWorkoutPresets(updatedWorkoutPreset : Workout) async throws {
        Task{
            do{
                let authDataResults = try AuthenticationManager.shared.getAuthenticatedUser()
                try await UserManager.shared.updateWorkoutPresets(userId: authDataResults.uid, updatedWorkoutPreset: updatedWorkoutPreset)
            } catch{
                print("error \(error)")
            }
        }
    }
}
