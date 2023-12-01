//
//  UserManager.swift
//  WorkUp
//
//  Created by Elijah Ochoa on 11/28/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser : Codable {
    let userId :  String
    let email : String?
    let photo_url : String?
    let dateCreated : Date?
    
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photo_url = auth.photoUrl
        self.dateCreated = Date()
        
    }
//    init(uid : String, email :String? = nil, photo_url : String? = nil, dateCreated : Date? = nil){
//        self.userId=uid
//        self.email = email
//        self.photo_url = photo_url
//        self.dateCreated = dateCreated
//    }
    enum CodingKeys : String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photo_url = "photo_url"
        case dateCreated = "date_created"
        
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self , forKey: .email)
        self.photo_url = try container.decodeIfPresent(String.self, forKey: .photo_url)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
    }
    func encode (from encoder : Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.photo_url, forKey: .photo_url)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        
    }
}
final class UserManager {
    static let shared = UserManager()
    private init(){}
    private let userCollection = Firestore.firestore().collection("users")
    private var trackedMealDayListener : ListenerRegistration? = nil
    
    
    private func userDocument(userId : String) -> DocumentReference {
        userCollection.document(userId)
        
    }
    
    //  Tracked Workouts
    private func trackedWorkoutCollection(userId:String) -> CollectionReference {
        userDocument(userId: userId).collection("tracked_workouts")
    }
    private func trackedWorkoutDocument(userId:String, trackedWorkoutId: String) -> DocumentReference {
        trackedWorkoutCollection(userId: userId).document(trackedWorkoutId)
    }
    
    //Tracked Meal Days
    private func trackedMealDayCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("tracked_meal_days")
    }
    private func mealDayDocument(mealDayId: String, userId: String) -> DocumentReference {
        trackedMealDayCollection(userId: userId).document(mealDayId)
    }
   
    // Workout Presets
    private func workoutPresetsCollection(userId : String) -> CollectionReference {
        userDocument(userId: userId).collection("workout_presets")
    }
    private func workoutPresetDocument(workoutId : String, userId: String) -> DocumentReference {
        workoutPresetsCollection(userId: userId).document(workoutId)
    }
    private let encoder : Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder : Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    func createNewUser(user: DBUser)async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false,encoder: encoder)
        Task{
            do{
                try await createDefaultUser(userId: user.userId)
            }catch{
                print("create default error \(error)")
            }
        }
    }
    func createDefaultUser(userId: String) async throws{
        let bicepCurl = Exercise(name : "Bicep Curl", reps : 12, sets : 5, pr : 120)
        let tricepCurl = Exercise(name : "Tricep Curl", reps : 12, sets: 5, pr: 150)
        let armWorkoutList : [Exercise] = [bicepCurl, tricepCurl]
        
        let benchPress = Exercise(name : "Bench Press", reps : 12, sets : 5 , pr : 250)
        let inclinePress = Exercise(name : "Incline Press", reps : 12, sets : 5, pr : 280)
        let chestWorkoutList : [Exercise] = [benchPress, inclinePress]
        
        let chestWorkout = Workout(title: "Chest Workout", workoutId: "", exerciseList: chestWorkoutList)
        
        let armWorkout = Workout(title: "Arm Workout", workoutId: "", exerciseList: armWorkoutList)
        Task{
            do{
                
                try await addWorkoutPreset(userId: userId, newWorkoutPreset: chestWorkout)
                try await addWorkoutPreset(userId: userId, newWorkoutPreset: armWorkout)
            }catch{
                print("error : \(error)")
            }
        }
        
        
    }
//    func createNewUser(auth : AuthDataResultModel) async throws {
//        var userData : [String: Any] = [
//            "user_id" : auth.uid,
//            "date_created" : Timestamp(),
//        ]
//        if let email = auth.email {
//            userData["email"] = email
//        }
//        if let photoUrl = auth.photoUrl {
//            userData["photo_url"] = photoUrl
//        }
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//    }
    func getUser(userId : String) async throws -> DBUser {
        return try await userDocument(userId: userId).getDocument(as: DBUser.self)
        
    }
    func addMealDay(userId: String, newMealDay: mealDay , newMealDate : Date) async throws{
        let document = trackedMealDayCollection(userId: userId).document()
        let documentId = document.documentID
        let preparedMealDay = mealDay(dayId: documentId,mealList : newMealDay.mealList, mealDate: newMealDay.mealDate)
        
//        let data : [String: Any] = [
//            "date" : newMealDay.mealDay,
//            "meals"  : newMealDay.mealList,
//            "day_id" : documentId
//        ]
        
        try document.setData(from: preparedMealDay, merge: false)
    }
    func editMealDay(userId: String, updatedMealDay : mealDay) async throws{
        
        try mealDayDocument(mealDayId: updatedMealDay.dayId, userId: userId).setData(from: updatedMealDay, merge: true)
    }
    func getAllTrackedMealDays(userId : String) async throws -> [mealDay]{
        let snapShot = try await trackedMealDayCollection(userId: userId).getDocuments()
        var mealDays: [mealDay] = []
        for document in snapShot.documents {
            let mealDay = try document.data(as: mealDay.self)
            mealDays.append(mealDay)
        }
        return mealDays
    }
    
    
    func addWorkoutPreset(userId: String, newWorkoutPreset : Workout) async throws {
        let document = workoutPresetsCollection(userId: userId).document()
        let preparedWorkout : Workout = Workout(title: newWorkoutPreset.title, workoutId: document.documentID, exerciseList: newWorkoutPreset.exerciseList)
//        let data : [String : Any] = [
//            "title" : newWorkoutPreset.title,
//            "workout_id" : document.documentID,
//            "exercise_list" : newWorkoutPreset.exerciseList
//        ]
        try document.setData(from : preparedWorkout, merge: false)
    }
    func updateWorkoutPresets(userId : String, updatedWorkoutPreset : Workout) async throws {
       
        try workoutPresetDocument(workoutId: updatedWorkoutPreset.workoutId, userId: userId).setData(from : updatedWorkoutPreset, merge: false)
    }
    func getAllWorkoutPresets(userId : String) async throws -> [Workout]{
        let snapShot = try await workoutPresetsCollection(userId: userId).getDocuments()
        var workouts : [Workout] = []
        for document in snapShot.documents {
            let workout = try document.data(as: Workout.self)
            workouts.append(workout)
        }
        return workouts
    }
    func getWorkoutPreset(userId: String, workoutId : String) async throws -> Workout{
        try await workoutPresetDocument(workoutId: workoutId, userId: userId).getDocument(as: Workout.self)
    }
    func addTrackedWorkout(userId: String, newTrackedWorkout : TrackedWorkout) async throws {
        let document = trackedWorkoutCollection(userId: userId).document()
        let preparedTrackedWorkout = Workout(title: newTrackedWorkout.title, workoutId: document.documentID, exerciseList: newTrackedWorkout.exerciseList)
        
//        let data : [String : Any] = [
//            "title" : newTrackedWorkout.title,
//            "workout_id" : newTrackedWorkout.workoutId,
//            "exercise_list" : document.documentID,
//            "workout_date" : newTrackedWorkout.workoutDate
//            
//        ]
        
        
        try document.setData(from :preparedTrackedWorkout, merge: false)
    }
    func updateTrackedWorkout(userId: String, updatedTrackedWorkout : TrackedWorkout) async throws {
        
        try workoutPresetDocument(workoutId: updatedTrackedWorkout.workoutId, userId: userId).setData(from: updatedTrackedWorkout, merge: true)
    }
    
    func getAllTrackedWorkouts(userId: String) async throws -> [TrackedWorkout]{
        let snapShot = try await trackedWorkoutCollection(userId: userId).getDocuments()
        var trackedWorkouts : [TrackedWorkout] = []
        for document in snapShot.documents {
            let workout = try document.data(as: TrackedWorkout.self)
            trackedWorkouts.append(workout)
        }
        return trackedWorkouts
    }
//    func addListenerForTrackedMealDays(userId: String, completion: @escaping (_ days: [mealDay]) -> Void) {
//        self.trackedMealDayListener = trackedMealDayCollection(userId: userId).addSnapshotListener({querySnapshot, error in
//            guard let documents = querySnapshot?.documents else{
//                print("No tracked meal days")
//                return
//            }
//            let trackedMealDays : [mealDay] = documents.compactMap({try? $0.data(as: mealDay.self)  })
//            completion(trackedMealDays)
//            
//            querySnapshot?.documentChanges.forEach{ diff in
//                if(diff.type == .added){
//                    print("New tracked days \(diff.document.data())")
//                }
//                if(diff.type == .modified){
//                    print("modified day \(diff.document.data())")
//                }
//                if(diff.type == .removed){
//                    print("removed day \(diff.document.data())")
//                }
//            }
//            
//        })
//    }
//    func addListenerForTrackedMealDays(userId: String) -> AnyPublisher<[mealDay], Error>{
//        let (publisher, listener) = trackedMealDayCollection(userId: userId).addSnapshotListener(as: mealDay)
//        self.trackedMealDayListener = listener
//        return publisher
//    }

}

