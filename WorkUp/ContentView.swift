//
//  ContentView.swift
//  WorkUp
//
//  Created by Elijah Ochoa and Noah Fuentes on 10/31/23.
//

import SwiftUI
class ViewManager : ObservableObject{
    @Published var currentView : String = "loginView"
    
}
struct Event {
    var id = UUID()
    var date: Date
    var title: String
}
class UserData : ObservableObject {
    @Published var muscleGroups : [String]
    @Published var workoutNames : [String: [String]]
    @Published var events : [Event] = []
   
    init(){
        self.muscleGroups = ["Arms", "Chest", "Legs", "Core"]
        self.workoutNames = [
            "Arms" : ["Preacher Curl", "Hammer Curl", "Tricep Extention"],
            "Chest" : ["Bench Press", "Incline Press", "Cable Crossover"],
            "Legs" : ["Calf Raises", "Leg Press", "Deadift"],
            "Core" : ["Crunch", "Leg Raise", "Plank", "Situps"]
        ]
        let currentDate = Date()
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate)
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

struct ContentView: View {
    
    @ObservedObject var viewManager = ViewManager()
    var body: some View {
       
        if(viewManager.currentView == "loginView")
        {
            LoginView(viewManager: viewManager)
        } else if (viewManager.currentView == "createAccountView")
        {
            CreateAccountView(viewManager : viewManager)
        } else if(viewManager.currentView == "calendarView")
        {
            CalendarView(viewManager : viewManager)
        }else {
            Text("Unknown view \(viewManager.currentView)")
        }
   //     CalendarView(viewManager : viewManager)
        
    }
}
#Preview {
    ContentView()
}
