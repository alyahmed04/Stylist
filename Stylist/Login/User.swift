//
//  User.swift
//  LoginApp
//
//  User model representing authenticated users
//

import Foundation
import SwiftData

@Model
final class StyleQuiz: Identifiable {
    var id: String
    var style: String
    var fit: String
    var color: String
    var shoppingFreq: String
    
    init(id: String = UUID().uuidString, style: String, fit: String, color: String, shoppingFreq: String) {
        self.id = id
        self.style = style
        self.fit = fit
        self.color = color
        self.shoppingFreq = shoppingFreq
    }

    var isComplete: Bool {
        !style.isEmpty && !fit.isEmpty && !color.isEmpty && !shoppingFreq.isEmpty
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
         //  case styleQuiz
           case closet
       }
    

    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
      //  styleQuiz = try container.decode(StyleQuiz.self, forKey: .styleQuiz)
        closet = try container.decode([ClothingItem].self, forKey: .closet)
        id = try container.decode(String.self, forKey: .id)
        
    }
    

    var id: String
    var email: String
    var name: String
 //   var styleQuiz: StyleQuiz
    
    @Relationship(deleteRule: .cascade, inverse: \ClothingItem.user)
    var closet = [ClothingItem]()
    
    @Relationship(deleteRule: .cascade)
    var quizzes: [StyleQuiz] = []
    
    
    init(id: String, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
      //  self.styleQuiz = styleQuiz ?? StyleQuiz()
    }
    
    
    //variable to check if user needs to complete quiz
//    var hasCompletedQuiz: Bool {
//        return styleQuiz.isComplete
//    }
    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    //    try container.encode(styleQuiz, forKey: .styleQuiz)
        try container.encode(closet, forKey: .closet)
        try container.encode(id, forKey: .id)
    }
    
    var hasCompletedQuiz: Bool {
        return (!quizzes.isEmpty)
    }
    
    
}


