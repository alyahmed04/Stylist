//
//  User.swift
//  LoginApp
//
//  User model representing authenticated users
//

import Foundation
import SwiftData




//Learned how to make classes confirm to encodable and decodable from
//https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
@Model
final class User: Identifiable, Decodable, Encodable{
    
    
    enum CodingKeys: CodingKey {
           case email
           case id
           case name
           case stylePreferences
           case closet
       }
    

    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        stylePreferences = try container.decode(StylePreferences.self, forKey: .stylePreferences)
        closet = try container.decode([ClothingItem].self, forKey: .closet)
        id = try container.decode(String.self, forKey: .id)
        
    }
    

    var id: String
    var email: String
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \ClothingItem.user)
    var closet = [ClothingItem]()
    
    @Relationship(deleteRule: .cascade, inverse: \StylePreferences.user)
    var stylePreferences: StylePreferences?
    
    
    init(id: String, email: String, name: String, stylePreferences: StylePreferences? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.stylePreferences = stylePreferences
    }
    
    
    //variable to check if user needs to complete quiz
    var hasCompletedQuiz: Bool {
        return stylePreferences!.isComplete
    }
    
    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(stylePreferences, forKey: .stylePreferences)
        try container.encode(closet, forKey: .closet)
        try container.encode(id, forKey: .id)
    }
    
        
}


