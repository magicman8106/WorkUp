import SwiftUI

struct LoginView: View {
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var usernameValidationString : String = ""
    @State private var passwordValidationString : String = ""
    var body: some View {
        VStack {
           
            Text("Workup")
                .foregroundColor(Color.white)
                .font(.custom("openSans", size: 60.0))
            
            
            VStack{
                HStack{
                    Text("Username: ")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 25.0))
                    TextField("Username", text : $username).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                }
                if(usernameValidationString != "")
                {
                    Text(usernameValidationString).foregroundColor(Color.red).font(.custom("OpenSans-SemiBold", size: 15.0))
                }
                HStack{
                    Text("Password: ")
                        .foregroundColor(Color.white)
                        .font(.custom("OpenSans-SemiBold", size: 25.0)).frame(width: 140)
                    TextField("Password", text : $password).background(Color.white).frame(width: 150, height: 50).cornerRadius(25)
                }
                if(passwordValidationString != "")
                {
                    Text(passwordValidationString).foregroundColor(Color.red).font(.custom("OpenSans-SemiBold", size: 15.0))
                }
               
                
                Spacer()
                    .frame(height: 50.0)
                Text("Submit")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .font(.custom("OpenSans-SemiBold", size: 25.0))
            }
            .frame(width: 350, height: 250)
            .background(Color.black)
            .cornerRadius(25)
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color.appBackground.ignoresSafeArea())
        
    }
    private func validateUser(){
        print("The username is \(username) and the password is \(password)")
    }
}

#Preview {
    ContentView()
}
