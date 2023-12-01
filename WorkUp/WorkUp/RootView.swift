//
//  RootView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI
struct Event {
    var id = UUID()
    var date : Date
    var title :String
}
struct RootView : View {
    @State private var showSignInView : Bool = false
    
    var body :some View {
        ZStack{
            if !showSignInView{
                TabBarView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                LoginView(showSignInView : $showSignInView)
            }
        }
        
    }
}
