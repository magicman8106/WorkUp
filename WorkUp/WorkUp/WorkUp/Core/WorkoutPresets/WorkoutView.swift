//
//  WorkoutView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/1/23.
//

import SwiftUI

struct WorkoutView : View{
    @EnvironmentObject var userData : UserData
    @StateObject var viewModel = WorkoutPresetViewModel()
    @State var selectedMuscleGroupId : String = ""
    var body : some View{
       
        VStack{
            Spacer().frame(height: 70)
            Text("Fitness Tracker").foregroundColor(Color.white).foregroundColor(Color.white)
                .font(.custom("OpenSans-Bold", size: 40.0))
            Spacer().frame(height:30)
            Text("Workout Presets").foregroundColor(Color.white)
                .font(.custom("OpenSans-Bold", size: 30.0))
          
                List{
                    ForEach(viewModel.workoutPresets, id:\.workoutId) {
                        workout in
                            NavigationLink(destination:WorkoutExpandedCellView(workout: workout) ){
                                Text(workout.title)
                            }
                        .listRowBackground(
                            Capsule().fill(Color.white)).padding(1)
                            
                    }.listRowInsets(.init(top: 0, leading: 25, bottom : 0, trailing : 0))
                }.scrollContentBackground(.hidden)
                NavigationLink(destination : newWorkoutView()){
                    Text("Create new")
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
        .frame(maxWidth: .infinity)
        .background(Color.appBackground)
        .onAppear{
            viewModel.getWorkoutPresets()
        }
        }
}


#Preview {
    RootView()
}
