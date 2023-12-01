//
//  CalorieTrackerView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI

struct CalorieTrackerView : View{
    @EnvironmentObject var userData : UserData
    @StateObject var viewModel = WorkoutPresetViewModel()
    @State var selectedMealDayId : String = ""
    var body : some View{
       
        VStack{
            Spacer().frame(height: 70)
            Text("Calorie Tracker").foregroundColor(Color.white).foregroundColor(Color.white)
                .font(.custom("OpenSans-Bold", size: 40.0))
            Spacer().frame(height:30)
            Text("Days").foregroundColor(Color.white)
                .font(.custom("OpenSans-Bold", size: 30.0))
            VStack{
                List{
                    ForEach(viewModel.workoutPresets, id:\.workoutId) {
                        workout in
                        NavigationLink(destination:WorkoutExpandedCellView(workout: workout) ){
                            Text(workout.title)
                        }
                            
                       
    
                    }
                }
                
                Button("Create new"){selectedMealDayId = "Add workout"}
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
                
                
            }.padding(.vertical, 40.0).frame(width: 300.0, height: 400.0)
                .onAppear{
                    viewModel.getWorkoutPresets()
                }

            
            Spacer().frame(height: 200)
        }
        .frame(maxWidth: .infinity)
        .background(Color.appBackground)
        
            
    }
    
}


#Preview {
    RootView()
}
