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
    init(uid : String, email :String? = nil, photo_url : String? = nil, dateCreated : Date? = nil){
        self.userId=uid
        self.email = email
        self.photo_url = photo_url
        self.dateCreated = dateCreated
    }
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
    private func userDocument(userId : String) -> DocumentReference {
        userCollection.document(userId)
        
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
        return try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
        
    }
    func addMealDay(userId: String, newMealDay: mealDocument , newMealDate : Date) async throws{
        let document = userDocument(userId: userId).collection("dailyMeals").document()
        let documentId = document.documentID
        let data : [String: Any] = [
            "date" : newMealDay.mealDay,
            "meals"  : newMealDay.mealList,
            "day_id" : documentId
        ]
        try await document.setData(data, merge: false)
    }

}
