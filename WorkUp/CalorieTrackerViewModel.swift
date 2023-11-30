//
//  CalorieTrackerViewModel.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import Foundation
import SwiftUI
import Combine
import SwiftUI
struct Item : Codable {
    let name : String
    let calories : Int
    init(name : String, calories: Int) {
        self.name = name
        self.calories = calories
    }
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case calories = "calories"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.calories = try container.decode(Int.self, forKey: .calories)
    }
    func encode(to encoder : Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.calories, forKey: .calories)
    }

    
}
struct Meal : Codable {
    let mealTitle : String
    let itemList : [Item]
    init(mealTitle : String, itemList : [Item])
    {
        self.mealTitle = mealTitle
        self.itemList = itemList
    }
    enum CodingKeys : String, CodingKey {
        case mealTitle  = "meal_title"
        case itemList = "item_list"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealTitle = try container.decode(String.self, forKey: .mealTitle)
        self.itemList = try container.decode([Item].self, forKey: .itemList)
    }
    func encode(to encoder : Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.mealTitle, forKey: .mealTitle)
        try container.encode(self.itemList, forKey: .itemList)
    }

}
struct mealDay : Codable {
    let dayId : String
    let mealList : [Meal]
    let mealDate : Date
    init(dayId : String, mealList : [Meal], mealDate : Date){
        self.dayId = dayId
        self.mealList =  mealList
        self.mealDate = mealDate
    }
    enum CodingKeys : String, CodingKey {
        case dayId = "day_id"
        case mealList = "meal_list"
        case mealDate = "meal_date"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dayId = try container.decode(String.self, forKey: .dayId)
        self.mealList = try container.decode([Meal].self, forKey: .mealList)
        self.mealDate = try container.decode(Date.self, forKey: .mealDate)
    }
    func encode(to encoder : Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.dayId, forKey: .dayId)
        try container.encode(self.mealList, forKey: .mealList)
        try container.encode(self.mealDate, forKey: .mealDate)
    }

    
}


@MainActor
final class CalorieTrackerViewModel : ObservableObject {
    @Published private(set) var trackedDays : [mealDay] = []
    //private var cancellables = Set<AnyCancellable>()
    
    func getTrackedMealDays() {
        Task{
            do{
                let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
                self.trackedDays = try await UserManager.shared.getAllTrackedMealDays(userId: authDataResult.uid)
            } catch{
                print("error \(error)")
            }
            
        }
    }
    func updateTrackedMeals(updatedMealDay:mealDay) async throws{
        Task{
            do{
                let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
                try await UserManager.shared.editMealDay(userId: authDataResult.uid, updatedMealDay: updatedMealDay)
                getTrackedMealDays()
            }
        }
    }
   
    
    
}
