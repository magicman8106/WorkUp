//
//  SettingsView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/26/23.
//

import SwiftUI
final class SettingsViewModel: ObservableObject {
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    func updateEmail(newEmail:String) async throws
    {
        try await AuthenticationManager.shared.updateEmail(email: newEmail)
    }
}
struct SettingsView: View{
    @StateObject private var viewModel = SettingsViewModel()
    @ObservedObject var viewManager : ViewManager
    var body: some View{
        List{
            Button("Logout") {
                Task{
                    do {
                        try viewModel.logOut()
                        viewManager.currentView="loginView"
                    }catch {
                        print(error)
                    }
                }
            }
            Button("Reset Password") {
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch{
                        print("error")
                    }
                }
            }
            Button("Update Passwor"){
                
            }
        }
    }

}

#Preview {
    ContentView()
}
