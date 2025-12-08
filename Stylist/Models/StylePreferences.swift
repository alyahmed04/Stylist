//
//  StylePreferences.swift
//  Stylist
//
//  Created by Aly Ahmed on 12/7/25.
//

import Foundation

//
//  StyleQuizModel.swift
//  Stylist
//
//  Created by Aly Ahmed on 12/7/25.
//

import Foundation
import SwiftData


@Model
final class StylePreferences: Identifiable, Decodable, Encodable {
    
    
    enum CodingKeys: CodingKey {
            case id
            case style
            case fit
            case color
            case shoppingFreq
            case cost
       }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(String.self, forKey: .style)
        color = try container.decode(String.self, forKey: .color)
        fit = try container.decode(String.self, forKey: .fit)
        shoppingFreq = try container.decode(String.self, forKey: .shoppingFreq)
        id = try container.decode(UUID.self, forKey: .id)
        cost = try container.decode(String.self, forKey: .cost)
    }
        
        
        @Attribute(.unique) var id: UUID
        
        var style: String
        var user: User?
        var fit: String
        var color: String
        var shoppingFreq: String
        var cost: String
        
        
        
        
        init(id: UUID = UUID(), user: User? = nil, style: String, fit: String, color: String, shoppingFreq: String, cost: String) {
            self.id = id
            self.user = user
            self.style = style
            self.fit = fit
            self.color = color
            self.shoppingFreq = shoppingFreq
            self.cost = cost
        }
        
        var isComplete: Bool {
            !style.isEmpty && !fit.isEmpty && !color.isEmpty && !shoppingFreq.isEmpty
        }
        
        //Learned how to make classes confirm to encodable and decodable from
        //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(style, forKey: .style)
            try container.encode(color, forKey: .color)
            try container.encode(fit, forKey: .fit)
            try container.encode(shoppingFreq, forKey: .shoppingFreq)
            try container.encode(id, forKey: .id)
            try container.encode(cost, forKey: .cost)
        }
}
