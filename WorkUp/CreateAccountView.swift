//
//  CreateAccountView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 10/31/23.
//

import SwiftUI

struct CreateAccountView : View{
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var usernameValidationString : String = ""
    @State private var passwordValidationString : String = ""
    @ObservedObject var viewManager : ViewManager
    var body : some View {
        VStack {
           
            Text("Workup")
                .foregroundColor(Color.white)
                .font(.custom("openSans", size: 60.0))
            Spacer()
                .frame(height: 20.0)
            Text("Create Account")
                .foregroundColor(Color.white)
                .font(.custom("OpenSans-SemiBold", size: 40.0))
                
            Spacer()
                .padding(.bottom, 10.0)
                .frame(height: 20.0)
                
            VStack{
                HStack{
                    Text("Username: ")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 25.0))
                    TextField("Username", text : $viewModel.email).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                }
                if(usernameValidationString != "")
                {
//                    Text(usernameValidationString).foregroundColor(Color.red).font(.custom("OpenSans-SemiBold", size: 15.0))
                }
                HStack{
                    Text("Password: ")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 25.0)).frame(width: 140)
                    TextField("Password", text : $viewModel.password).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                }
                if(passwordValidationString != "")
                {
//                    Text(passwordValidationString).foregroundColor(Color.red).font(.custom("OpenSans-SemiBold", size: 15.0))
                }
                
                Spacer()
                    .frame(height: 50.0)
                Button("Submit"){
                    viewModel.signUp()
                    viewManager.currentView="calendarView"
                }
                    
                    .fontWeight(.bold)
                    .frame(width: 180)
                    .foregroundColor(Color.black)
                    .font(.custom("OpenSans-SemiBold", size: 25.0))
                    .background(Color.white)
                    .cornerRadius(20)
               
              
            }
            .frame(width: 350, height: 320)
            .background(Color.black)
            .cornerRadius(25)
            
        }
        .padding(.bottom, 200.0)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color("app_background"))

    }
    private func createAccount()
    {
        print("Account created")
        viewManager.currentView = "calendarView"
    }
}
#Preview {
    ContentView()
}

