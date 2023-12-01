//
//  WorkoutView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/1/23.
//

import SwiftUI
struct workoutView : View {
    @State var workout : String
    @EnvironmentObject var userData : UserData
    @StateObject var viewModel  = WorkoutPresetViewModel()
    var body : some View
    {
        VStack{
           Text("\(workout)")
            Spacer().frame(height: 20)
            ScrollView{
//                ForEach($userData.workoutNames[workout] ?? [], id: \.self){
//                    value in
//                    HStack{
//                        Text(value).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black).frame(width: 180)
//                    }
//                    
//                    
//                    
//                }
            }
            
            Button("Create new"){print("Create New")}
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

        }.padding(.vertical, 5.0).frame(width: 300).frame(maxWidth: .infinity) .font(.custom("OpenSans-SemiBold", size: 25.0))
            .background(Color.white).foregroundColor(Color.black).cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
                    .stroke(Color.black, lineWidth: 2) // Set the border color and width
            )
        
    }
}
struct WorkoutView : View{
    @ObservedObject var viewManager : ViewManager
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
            VStack{
                List{
                    ForEach(viewModel.workoutPresets, id:\.workoutId) {
                        workout in
                            WorkoutCollapsedCellView(workout: workout)
                       
//                        if(selectedMuscleGroupId == workout.workoutId) {
//                           Text("workut.")
//                        }
//                        else
//                        {
//                            Button(action: {selectedMuscleGroupId = group.workoutId}){
//                            Text(group.title).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black)}
//                                                        .padding(.vertical, 5.0).frame(width: 300).frame(maxWidth: .infinity) .font(.custom("OpenSans-SemiBold", size: 25.0))
//                        }
                       
                    }
                }
                
                
//                Spacer().frame(height: 20)
//                ScrollView{
//                   
//                    ForEach(userData.muscleGroups, id: \.self){
//                        group in
//                        if selectedMuscleGroupId == group {
//                            workoutView(workout: $group)
//                            }  else {
//                            Button(action: {selectedMuscleGroupId = group.workoutId}){
//                               
//                                Text(group.title).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black)
//                                   
//                                
//                            }
//                            .padding(.vertical, 5.0).frame(width: 300).frame(maxWidth: .infinity) .font(.custom("OpenSans-SemiBold", size: 25.0))
//                            .background(Color.white).foregroundColor(Color.black).cornerRadius(20)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20) // Overlay a rounded rectangle with the same corner radius
//                                    .stroke(Color.black, lineWidth: 2) // Set the border color and width
//                            )
//                            
//                        }
//                       
//                    }
//                }
                
                Button("Create new"){selectedMuscleGroupId = "Add workout"}
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
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color.appBackground)
        
            
    }
    
}


#Preview {
    ContentView()
}
