//
//  ContentView.swift
//  WorkUp
//
//  Created by Elijah Ochoa and Noah Fuentes on 10/31/23.
//

import SwiftUI
class ViewManager : ObservableObject{
    @Published var currentView : String = "workoutView"
    
}

struct Event {
    var id = UUID()
    var date: Date
    var title: String
}

struct navBar : View {
    @ObservedObject var viewManager : ViewManager
    var body : some View{
      
        VStack{                
            Spacer().frame(height: 70)

            HStack{
                
                VStack{
                    Image(systemName : "figure.strengthtraining.traditional").font(.system(size: 20))
                    Spacer().frame(height: 5)
                    Text("Workouts")
                }.onTapGesture {
                    changeView(newView : "workoutView")
                }.frame(height: 60)
                VStack{
                    Spacer().frame(height: 6)
                    Image(systemName : "calendar").font(.system(size: 20))
                    Spacer().frame(height: 5)
                    Text("Calendar").padding(.top, 2.0)
                }.onTapGesture {
                    changeView(newView : "calendarView")
                }.frame(height: 60)
            }.background(Color.navBar).cornerRadius(5)
                
        }
           
                
            
     
        
    }
    func changeView(newView : String)
    {
        viewManager.currentView=newView
    }
}
struct ContentView: View {

    @ObservedObject var viewManager = ViewManager()
    @StateObject var userData = UserData()
    var body: some View {
        
            ZStack{
                if(viewManager.currentView == "loginView")
                {
                    LoginView(viewManager: viewManager)
                } else if (viewManager.currentView == "createAccountView")
                {
                    CreateAccountView(viewManager : viewManager)
                } else if(viewManager.currentView == "calendarView")
                {
                    CalendarView(viewManager : viewManager)
                } else if (viewManager.currentView == "workoutView")
                {
                    WorkoutView(viewManager : viewManager)
                } else {
                    Text("Unknown view \(viewManager.currentView)")
                }
               
                if(viewManager.currentView != "loginView")
                {
                   
                    VStack{
                        Spacer().frame(height: 700).background()
                        navBar(viewManager: viewManager)
                    }
                    
                    
                    
                }
            }
        
//        ZStack{
//            WorkoutView(viewManager : viewManager)
//            VStack{
//                Spacer().frame(height: 700).background()
//                navBar(viewManager: viewManager)
//            }
            .environmentObject(userData)
        }
        
}//end of ContentView

#Preview {
    ContentView()
}
