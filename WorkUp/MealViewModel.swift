//
//  MealViewModel.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/29/23.
//

import SwiftUI
struct Item : Codable {
    let calories : Int
    let name : String
    init(calories : Int, name : String )  {
        self.calories =  calories
        self.name = name
    }
}
struct Meal : Codable {
    let mealTitle : String
    let itemList : [Item]
    init (itemList : [Item], mealTitle :String) {
        self.itemList = itemList
        self.mealTitle = mealTitle
    }
}
struct mealDocument : Codable {
    let mealList : [Meal]
    let mealDay : Date
    
    init(mealList : [Meal], mealDay: Date, mealListId: String){
        self.mealList = mealList
        self.mealDay = mealDay
    }
}

