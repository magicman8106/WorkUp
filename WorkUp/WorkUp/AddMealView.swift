//
//  AddMealView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI

struct addMealView : View {
    @EnvironmentObject var userData : UserData
    
    @State private var mealName : String = ""
    
    @State var date = Date()
    
    @State private var foodName1 : String = ""
    @State private var foodName2 : String = ""
    @State private var foodName3 : String = ""
    @State private var foodName4 : String = ""
    @State private var foodName5 : String = ""
    
    @State private var calCount1 : String = ""
    @State private var calCount2 : String = ""
    @State private var calCount3 : String = ""
    @State private var calCount4 : String = ""
    @State private var calCount5 : String = ""
    
    var body : some View
    {
        VStack{
            Spacer().frame(height: 60)
            Text("Add a Meal")
                .foregroundColor(Color.white)
                .font(.custom("openSans", size: 60.0))
            Spacer().frame(height: 100)
            VStack{
                HStack{
                    Text("Meal Name:")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 20.0))
                    TextField(" Enter meal name", text:$mealName).background(Color.white).frame(width: 180, height: 50).cornerRadius(25)
                }
                HStack{
                    TextField(" Enter item name", text:$foodName1).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                    Text("   Calories:")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 18.0))
                    TextField(" cals", text:$calCount1).background(Color.white).frame(width: 50, height: 50).cornerRadius(25)
                }.padding(-10)
                HStack{
                    TextField(" Enter item name", text:$foodName2).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                    Text("   Calories:")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 18.0))
                    TextField(" cals", text:$calCount2).background(Color.white).frame(width: 50, height: 50).cornerRadius(25)
                }.padding(-10)
                HStack{
                    TextField(" Enter item name", text:$foodName3).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                    Text("   Calories:")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 18.0))
                    TextField(" cals", text:$calCount3).background(Color.white).frame(width: 50, height: 50).cornerRadius(25)
                }.padding(-10)
                HStack{
                    TextField(" Enter item name", text:$foodName4).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                    Text("   Calories:")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 18.0))
                    TextField(" cals", text:$calCount4).background(Color.white).frame(width: 50, height: 50).cornerRadius(25)
                }.padding(-10)
                HStack{
                    TextField(" Enter item name", text:$foodName5).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                    Text("   Calories:")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 18.0))
                    TextField(" cals", text:$calCount5).background(Color.white).frame(width: 50, height: 50).cornerRadius(25)
                }.padding(-10)
                Spacer().frame(height: 20)
                DatePicker(" Date:", selection:$date, displayedComponents:.date).background(Color.white).frame(width: 200, height: 50).cornerRadius(25)
                Spacer().frame(height: 20)
                Button("Done"){
                    addMeal()
                }
                    .fontWeight(.bold)
                    .frame(width: 100, height: 40)
                    .foregroundColor(Color.black)
                    .font(.custom("OpenSans-SemiBold", size: 25.0))
                    .background(Color.white)
                    .cornerRadius(20)
            }.frame(width: 350, height: 450)
            .background(Color.black)
            .cornerRadius(25)
            
                
        }.padding(.bottom, 200.0)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color("app_background"))
    }
    
    func addMeal(){
        
    }
}
#Preview {
    addMealView()
}
