//
//  CalorieTrackmerViewModel.swift
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
//    init(calories : Int, name : String )  {
//        self.calories =  calories
//        self.name = name
//    }
    
}
struct Meal : Codable {
    let mealTitle : String
    let itemList : [Item]
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
//    init (itemList : [Item], mealTitle :String) {
//        self.itemList = itemList
//        self.mealTitle = mealTitle
//    }
}
struct mealDay : Codable {
    let dayId : String
    let mealList : [Meal]
    let mealDay : Date
    enum CodingKeys : String, CodingKey {
        case dayId = "day_id"
        case mealList = "meal_list"
        case mealDay = "meal_day"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dayId = try container.decode(String.self, forKey: .dayId)
        self.mealList = try container.decode([Meal].self, forKey: .mealList)
        self.mealDay = try container.decode(Date.self, forKey: .mealDay)
    }
    func encode(to encoder : Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.dayId, forKey: .dayId)
        try container.encode(self.mealList, forKey: .mealList)
        try container.encode(self.mealDay, forKey: .mealDay)
    }
//    init(mealList : [Meal], mealDay: Date, mealListId: String){
//        self.mealList = mealList
//        self.mealDay = mealDay
//    }
    
}


@MainActor
final class CalorieTrackerViewModel : ObservableObject {
    @Published private(set) var trackedDays : [mealDay] = []
    private var cancellables = Set<AnyCancellable>()
    
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
    //    func addListenerForTrackedMealDays(){
    //        guard let authDataResult = try? AuthenticationManager.shared.getAuthenticatedUser() else {return}
    //
    //        UserManager.shared.addListenerForTrackedMealDays(userId: authDataResult.uid)
    //            .sink{ completion in
    //
    //            } receiveValue : { [weak self] days in
    //                self?.trackedDays = days
    //            }
    //            .store(in: &cancellables)
    //
    //        }
    //    }
    
    
}
