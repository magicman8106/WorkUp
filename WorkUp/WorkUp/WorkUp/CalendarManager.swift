//
//  CalendarManager.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/29/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


final class CalendarManager {
    static let shared = CalendarManager()
    private init(){}
    private let calendarCollection = Firestore.firestore().collection("workoutPresets")
    private func calendarDocument(){
        
    }
    
}
