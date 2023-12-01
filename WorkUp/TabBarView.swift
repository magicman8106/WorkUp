//
//  TabBarView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI
struct TabBarView : View {
    @Binding var showSignInView : Bool
    var body : some View{
        
        TabView{
            NavigationStack{
                WorkoutView()
                    
            }.tabItem {
                Image(systemName : "figure.strengthtraining.traditional").font(.system(size: 20))
                
                Text("Workouts")
            }
            NavigationStack{
                CalorieTrackerView()
                  
            }.tabItem{
                Image(systemName : "figure.strengthtraining.traditional").font(.system(size: 20))
                Spacer().frame(height: 5)
                Text("Calories")
            }
            NavigationStack{
                CalendarView()
                
            }.tabItem{
                    Spacer().frame(height: 6)
                    Image(systemName : "calendar").font(.system(size: 20))
                    Text("Calendar").padding(.top, 2.0)
                }
            NavigationStack{
                ProfileView(showSignInView: $showSignInView)
            }.tabItem{
                Spacer().frame(height: 6)
                Image(systemName : "person.circle").font(.system(size: 20))
                Spacer().frame(height: 5)
                Text("Profile").padding(.top, 2.0)
            }
        }
    }
}
