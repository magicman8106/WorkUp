//
//  CalendarView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 10/31/23.
//

import SwiftUI
import FSCalendar
class CalendarViewManager : ObservableObject{
    @Published  var selectedDate : Date? = nil
}

struct WorkoutPicker : View{
    @Binding var dateString : String
    @ObservedObject var calendarViewManager : CalendarViewManager
    @ObservedObject var userData : UserData
    @Binding var showWorkoutView : Bool
    @State var selectedWorkouts : Set<String> = []
    @State private var selectedMuscleGroup : String = ""
   
    var body : some View{
        VStack{
            HStack{
                Button(action :{ goBack()}){
                    Image(systemName: "arrow.left.to.line")
                        .foregroundColor(Color.black)
                        .padding(.leading, 60.0)
                }
                
                Spacer()
                    .frame(width: 10.0)
                Text("\(dateString)").font(.custom("OpenSans-SemiBold", size: 20.0)).frame(width: 150)
                Spacer()
                    .frame(width: 90.0)
                    
            }.padding(.top, 30.0)
            
            if(selectedMuscleGroup == "")
            {
                VStack{
                    
                    Text("Choose muscle group").font(.custom("OpenSans-SemiBold", size: 20.0))
                    Spacer().frame(height: 20)
                    ScrollView{
                        ForEach(userData.muscleGroups, id: \.self){
                            group in
                            Button(action: {selectedMuscleGroup = group}){
                                Text(group).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black)
                            }
                            .padding(.bottom, 10.0)
                            
                        }
                    }
                    
                    Button("Create new"){selectedMuscleGroup = "New"}
                        .fontWeight(.bold)
                        .frame(width: 210, height : 50 )
                        .foregroundColor(Color.black)
                        .font(.custom("OpenSans-SemiBold", size: 25.0))
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                                .stroke(Color.black, lineWidth: 2) // Set the border color and width
                        )
                    
               }
            } else {
                VStack{
                    Text(selectedMuscleGroup).font(.custom("OpenSans-SemiBold", size: 20.0))
                    ScrollView{
                        ForEach(userData.workoutNames[selectedMuscleGroup] ?? [], id: \.self){
                            value in
                            HStack{
                                Text(value).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black).frame(width: 180)
                                Spacer().frame(width : 10)
                                Image(systemName: selectedWorkouts.contains(value) ? "checkmark.circle.fill" : "checkmark.circle").foregroundColor(.green).frame(width: 30.0, height: 30.0).font(.system(size: 30))

                            } .onTapGesture {
                                if selectedWorkouts.contains(value) {
                                    selectedWorkouts.remove(value)
                                   
                                } else {
                                    selectedWorkouts.insert(value)
                                }
                            }
                            
                            
                            
                        }
                    }
                    Button("Submit"){submit()}.fontWeight(.bold)
                        .frame(width: 210, height : 50 )
                        .foregroundColor(Color.black)
                        .font(.custom("OpenSans-SemiBold", size: 25.0))
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                                .stroke(Color.black, lineWidth: 2) // Set the border color and width
                        )
                    Button("Create new"){createNew()}
                        .fontWeight(.bold)
                        .frame(width: 210, height : 50 )
                        .foregroundColor(Color.black)
                        .font(.custom("OpenSans-SemiBold", size: 25.0))
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                                .stroke(Color.black, lineWidth: 2) // Set the border color and width
                        )
                    
                    
                }
                
            }
             
        }
        
        
    }
    func createNew(){
        
    }
    func submit(){
        userData.addEvent(date: calendarViewManager.selectedDate ?? Date(), title: "Workout")
    }
    func goBack(){
        if(selectedMuscleGroup != "")
        {
            //de select muscle group
            selectedMuscleGroup = ""
        } else {
            //go back to detail view
            showWorkoutView = false
        }
    }
    
    
    
}
struct DateDetailView : View{
    @ObservedObject var calendarViewManager : CalendarViewManager
    @State var selectedDateString : String
    @State private var showAddWorkoutView : Bool = false
    @ObservedObject var userData : UserData

    var body : some View{
        VStack{
            if(showAddWorkoutView)
            {
                WorkoutPicker(dateString : $selectedDateString,calendarViewManager : calendarViewManager, userData: userData, showWorkoutView: $showAddWorkoutView)
            } else {
                if let selectedDate = calendarViewManager.selectedDate {
                    Text(formattedDate(from : selectedDate)).font(.custom("OpenSans-SemiBold", size: 20.0))
                } else {
                    Text("Select a date").font(.custom("OpenSans-SemiBold", size: 20.0))
                }
                Spacer().frame(height: 30)
                VStack(alignment: .leading){
                    HStack{
                        Text("Exercise Routine: Arms").font(.custom("OpenSans-SemiBold", size: 20.0))
                    }
                    HStack{
                        Text("Total calories: 63").font(.custom("OpenSans-SemiBold", size: 20.0))
                    }
                    
                    Spacer().frame(height : 40)
                }
                
                Button("Add Workouts"){showAddWorkoutView = true}
                    .fontWeight(.bold)
                    .frame(width: 210, height : 50 )
                    .foregroundColor(Color.black)
                    .font(.custom("OpenSans-SemiBold", size: 25.0))
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                            .stroke(Color.black, lineWidth: 2) // Set the border color and width
                    )
                    
                Spacer().frame(height : 10)
                Button("Add Meals"){addMeals()}
                    .fontWeight(.bold)
                    .frame(width: 210, height : 50 )
                    .foregroundColor(Color.black)
                    .font(.custom("OpenSans-SemiBold", size: 25.0))
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                            .stroke(Color.black, lineWidth: 2) // Set the border color and width
                    )
            }
        }.padding(.bottom, 30.0).frame(width: 250.0, height: 400.0).background(Color.white.opacity(0.9)).cornerRadius(20).overlay(
            RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                .stroke(Color.black, lineWidth: 2) // Set the border color and width
        )
        }
        
    func formattedDate(from date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EE, MMM d"
           return dateFormatter.string(from: date)
       }
    func addWorkout(){
        print("add workout")
    }
    func addMeals(){
        print("add meal")
    }
}
struct CalendarView : View{
    
   
    @State var selectedDateString : String = ""
    @ObservedObject var viewManager : ViewManager
    @ObservedObject var calendarViewManager = CalendarViewManager()
    @ObservedObject var userData = UserData()
    var body : some View {
        ZStack{
            CalendarViewRepresentable(selectedDate: $calendarViewManager.selectedDate, selectedDateString: $selectedDateString, events : $userData.events)
            if(calendarViewManager.selectedDate != nil)
            {
                VStack{
                    Spacer().frame(height: 75)
                    DateDetailView(calendarViewManager : calendarViewManager, selectedDateString: selectedDateString, userData : userData)
                        .padding(.bottom, 200.0)
                }
                
            }
            
            
        }
        .background(Color.appBackground)
    }
}
struct CalendarViewRepresentable : UIViewRepresentable{
    typealias UIViewType = FSCalendar
    @Binding var selectedDate: Date?
    @Binding var selectedDateString : String
    @Binding var events: [Event]
    fileprivate var calendar = FSCalendar()
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        calendar.appearance.weekdayTextColor = UIColor.white
        calendar.appearance.weekdayFont = UIFont(name : "OpenSans-SemiBold", size : 20)
        
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.headerTitleFont = UIFont(name : "OpenSans-SemiBold", size: 35)
        
       calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        
       calendar.appearance.titleWeekendColor = UIColor.white
        calendar.appearance.titleDefaultColor = UIColor.white
        calendar.appearance.titleFont = UIFont(name : "OpenSans-SemiBold", size : 15)
        calendar.appearance.headerDateFormat = "MMMM"
        calendar.scope = .month
                calendar.clipsToBounds = true
        
        return calendar
    }
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
           Coordinator(self)
    }
    class Coordinator: NSObject,
             FSCalendarDelegate, FSCalendarDataSource 
    {
        var parent: CalendarViewRepresentable
        var selectedDate: Date?
        init(_ parent: CalendarViewRepresentable)
        {
            self.parent = parent
        }
        fileprivate lazy var dateFormatter2: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
                    let matchingEvents = parent.events.filter { $0.date == date }
                    return matchingEvents.count
                }

                func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
                    let matchingEvents = parent.events.filter { $0.date == date }
                    if !matchingEvents.isEmpty {
                        
                        return [UIColor.white] // Set the event dot color
                    }
                    return nil
                }
        
       
       
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
                    // Update the selected date in the parent view.
                    parent.selectedDate = date
                    parent.selectedDateString = formattedDate(from: date)
                }
        func formattedDate(from date: Date) -> String {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "EE, MMM d"
               return dateFormatter.string(from: date)
           }
       
      
    }
   
    
}

#Preview {
    ContentView()
}
extension Date {

    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
         return nil
        }
        return date
    }
}

