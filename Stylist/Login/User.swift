//
//  User.swift
//  LoginApp
//
//  User model representing authenticated users
//

import Foundation
import SwiftData

struct StyleQuiz: Codable {
    var style: String
    var fit: String
    var color: String
    var shoppingFreq: String
    
    var isComplete: Bool {
        return !style.isEmpty && !fit.isEmpty && !color.isEmpty && !shoppingFreq.isEmpty
    }
        
    init(style: String = "", fit: String = "", color: String = "", shoppingFreq: String = "") {
        self.style = style
        self.fit = fit
        self.color = color
        self.shoppingFreq = shoppingFreq
    }
}

//Learned how to make classes confirm to encodable and decodable from
//https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
@Model
final class User: Identifiable, Decodable, Encodable{
    
    
    enum CodingKeys: CodingKey {
           case email
           case id
           case name
           case styleQuiz
           case closet
       }
    

    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        styleQuiz = try container.decode(StyleQuiz.self, forKey: .styleQuiz)
        closet = try container.decode([ClothingItem].self, forKey: .closet)
        id = try container.decode(String.self, forKey: .id)
        
    }
    

    var id: String
    var email: String
    var name: String
    var styleQuiz: StyleQuiz
    
    @Relationship(deleteRule: .cascade, inverse: \ClothingItem.id)
    var closet = [ClothingItem]()
    
    
    init(id: String, email: String, name: String, styleQuiz: StyleQuiz? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.styleQuiz = styleQuiz ?? StyleQuiz()
    }
    
    
    //variable to check if user needs to complete quiz
    var hasCompletedQuiz: Bool {
        return styleQuiz.isComplete
    }
    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(styleQuiz, forKey: .styleQuiz)
        try container.encode(closet, forKey: .closet)
        try container.encode(id, forKey: .id)
    }
    
    
}


