//
//  UserDataClass.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/2/23.
//

import SwiftUI
class UserData : ObservableObject {
    @Published var muscleGroups : [String]
    @Published var months : [String]
    @Published var workoutNames : [String: [String]]
    @Published var monthsOfYear : [String: [String]]
    @Published var events : [Event] = []
   
    init(){
        self.muscleGroups = ["Arms", "Chest", "Legs", "Core"]
        self.months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        self.workoutNames = [
            "Arms" : ["Preacher Curl", "Hammer Curl", "Tricep Extention"],
            "Chest" : ["Bench Press", "Incline Press", "Cable Crossover"],
            "Legs" : ["Calf Raises", "Leg Press", "Deadift"],
            "Core" : ["Crunch", "Leg Raise", "Plank", "Situps"]
        ]
        self.monthsOfYear = [
            "Jan" : ["test1", "test2"],
            "Feb" : ["test3", "test4"],
            "Mar" : [],
            "Apr" : [],
            "May" : [],
            "Jun" : [],
            "Jul" : [],
            "Aug" : [],
            "Sep" : [],
            "Oct" : [],
            "Nov" : ["nov test", "nov test2"],
            "Dec" : ["dec1", "dec2"]
        ]
        let currentDate = Date()
        let calendar = Calendar.current
        _ = calendar.date(byAdding: .day, value: 1, to: currentDate)
        generateEventsForTomorrowAndDayAfter()
        
    }
    private func generateEventsForTomorrowAndDayAfter() {
            let currentDate = Date()
            let calendar = Calendar.current

            // Calculate date for tomorrow
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate)
            
            // Calculate date for the day after tomorrow
            let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: currentDate)

            // Check if the dates were calculated successfully
            if let tomorrow = tomorrow, let dayAfterTomorrow = dayAfterTomorrow {
                // Create events for tomorrow and the day after
                let eventTomorrow = Event(date: tomorrow, title: "Event for Tomorrow")
                let eventDayAfterTomorrow = Event(date: dayAfterTomorrow, title: "Event for Day After Tomorrow")

                // Append the events to the events array
                events.append(eventTomorrow)
                events.append(eventDayAfterTomorrow)
            }
    }
    func addEvent(date: Date, title: String) {
            let newEvent = Event(date: date, title: title)
            events.append(newEvent)
        }
}
