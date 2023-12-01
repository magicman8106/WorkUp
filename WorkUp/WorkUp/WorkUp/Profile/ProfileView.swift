//
//  ProfileView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/28/23.
//

import SwiftUI
@MainActor
final class ProfileViewModel : ObservableObject{
    @Published private (set) var user: DBUser? = nil
    func loadCurrentUser() async throws {
        print("running vm get func")
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        print(user?.email ?? "none")
    }
}
struct ProfileView: View{
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView : Bool

    var body: some View{
        
            List{
                if let user = viewModel.user{
                    Text("UserId: \(user.userId)")
                }
                if let userEmail = viewModel.user?.email{
                    Text("Email: \(userEmail)")
                }
                HStack{
                    
                }
            }
            .task{
                do{
                    try await viewModel.loadCurrentUser()
                }
                catch{
                    print("error \(error)")
                }
            }
            .navigationTitle("Profile").toolbar{
                
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink{
                        SettingsView(showSignInView: $showSignInView)
                    } label : {
                        Image(systemName:"gear")
                            .font(.headline)
                    }
               
            }
        }
           
    
            
        
    }
}
struct ProfileView_Previews : PreviewProvider {
    static var previews : some View {
        RootView()
    }
}
