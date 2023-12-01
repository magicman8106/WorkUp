//
//  newWorkoutView.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/30/23.
//

import SwiftUI

struct newWorkoutView : View {
    @State private var newExercise : Int = 1
    @State private var unsetExerciseList : [Exercise] = []
    var body  : some View{
        VStack{
            List{
                ForEach(0..<newExercise, id :\.self){
                    index in
                    
                }
            }
            Button("Add Exercise"){
                newExercise+=1
            }
        }
    }
}
