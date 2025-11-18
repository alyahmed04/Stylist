//
//  User.swift
//  LoginApp
//
//  User model representing authenticated users
//

import Foundation

struct StyleQuiz: Codable {
    var style: String
    var fit: String
    var color: String
    var shoppingFreq: String
}


struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    var styleQuiz: StyleQuiz
    var closet: [ClothingItem] = []
    
    
    init(id: String, email: String, name: String, styleQuiz: StyleQuiz? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.styleQuiz = styleQuiz!
    }
}


