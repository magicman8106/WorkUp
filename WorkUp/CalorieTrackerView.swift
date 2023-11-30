//
//  CalorieTrackerView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI
struct dayMealsView : View {
    
    @EnvironmentObject var userData : UserData
    @Binding var monthToShow : String
    
    var body : some View
    {
        VStack{
            Text("")
            Spacer().frame(height: 20)
            ScrollView{
                ForEach(userData.monthsOfYear[monthToShow] ?? [], id: \.self){
                    value in
                    HStack{
                        Text(value).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black).frame(width: 180)
                    }
                }
            }
        }.padding(.vertical, 5.0).frame(width: 300).frame(maxWidth: .infinity) .font(.custom("OpenSans-SemiBold", size: 25.0))
            .background(Color.white).foregroundColor(Color.black).cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

struct CalTrackerView : View{
    
    @ObservedObject var viewManager : ViewManager
    @EnvironmentObject var userData : UserData
    @State var monthToShow : String = ""
    
    var body : some View{
        VStack{
            Spacer().frame(height: 70)
            Text("Calorie Tracker").foregroundColor(Color.white).foregroundColor(Color.white)
                .font(.custom("OpenSans-Bold", size: 40.0))
            Spacer().frame(height:30)
            Text("Select Month").foregroundColor(Color.white)
                .font(.custom("OpenSans-Bold", size: 30.0))
            
            VStack{
                
                
                Spacer().frame(height: 20)
                ScrollView{
                    ForEach(userData.months, id: \.self){
                        group in
                        if (group == monthToShow)
                        {
                            dayMealsView(monthToShow: $monthToShow)
                        } else {
                            Button(action: {monthToShow = group}){
                               
                                    Text(group).font(.custom("OpenSans-SemiBold", size: 20.0)).foregroundColor(.black)
                                   
                                
                            }
                            .padding(.vertical, 5.0).frame(width: 300).frame(maxWidth: .infinity) .font(.custom("OpenSans-SemiBold", size: 25.0))
                            .background(Color.white).foregroundColor(Color.black).cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            
                        }
                       
                    }
                }
                
                Button("Add New Meal"){}
                    .fontWeight(.bold)
                    .frame(width: 210, height : 50 )
                    .foregroundColor(Color.black)
                    .font(.custom("OpenSans-SemiBold", size: 25.0))
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                
            }.padding(.vertical, 40.0).frame(width: 300.0, height: 400.0)
                
            
            Spacer().frame(height: 200)
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color.appBackground)
    }
}
#Preview {
    ContentView()
}
