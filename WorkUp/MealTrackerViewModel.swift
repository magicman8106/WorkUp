//
//  MealTrackerViewModel.swift
//  WorkUp
//
//  Created by Noah Fuentes on 12/1/23.
//

import Foundation
import SwiftUI
import Combine
import SwiftUI
struct TrackedMeal : Codable{
    let name : String
    let mealId : String
    let itemList : [Item]
    let mealDate : Date
    
    init(name : String, mealId : String, itemList : [Item] , mealDate : Date){
        self.name = name
        self.mealId = mealId
        self.itemList = itemList
        self.mealDate = mealDate
    }
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case mealId = "meal_id"
        case itemList = "item_list"
        case mealDate = "meal_date"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.mealId = try container.decode(String.self, forKey: .mealId)
        self.itemList = try container.decode([Item].self, forKey: .itemList)
        self.mealDate = try container.decode(Date.self, forKey: .mealDate)
        
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.mealId, forKey: .mealId)
        try container.encode(self.itemList, forKey: .itemList)
        try container.encode(self.mealDate, forKey: .mealDate)
    }
    
}

@MainActor
final class CalorieTrackerViewModel : ObservableObject {
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

