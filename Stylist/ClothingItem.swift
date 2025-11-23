import SwiftUI
import Foundation
import SwiftData



enum ClothingCategory: String, Codable, CaseIterable, Identifiable {
    case top, bottom, outerwear, footwear, accessory
    public var id: String { rawValue }
}

enum ColorFamily: String, Codable, CaseIterable, Identifiable {
    case none = "none"
    case black = "black"
    case white = "white"
    case blue = "blue"
    case red = "red"
    case green = "green"
    case yellow = "yellow"
    case brown = "brown"
    case gray = "gray"
    case purple = "purple"
    case orange = "orange"
    case pink = "pink"
    public var id: String { rawValue }
}

enum Fit: String, Codable, CaseIterable, Identifiable {
    case slim = "slim"
    case regular = "regular"
    case relaxed = "relaxed"
    case oversized = "oversized"
    public var id: String { rawValue }
}

enum Occasion: String, Codable, CaseIterable, Identifiable {
    case casual, smartCasual, business, formal, active
    public var id: String { rawValue }
}

enum BudgetLevel: String, Codable, CaseIterable, Identifiable {
    case low, medium, high
    public var id: String { rawValue }
}


//Learned how to make classes confirm to encodable and decodable from
//https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
@Model
final class ClothingItem: Identifiable, Decodable, Encodable {
    
    
    enum CodingKeys: CodingKey {
        case id
        case userId
        case name
        case category
        case mainColor
        case accentColor
        case fit
        case notes
        case brand
        case isFavorite
        
       }
    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(ClothingCategory.self, forKey: .category)
        mainColor = try container.decode(ColorFamily.self, forKey: .mainColor)
        accentColor = try container.decode(ColorFamily.self, forKey: .accentColor)
        fit = try container.decode(Fit.self, forKey: .fit)
        notes = try container.decode(String.self, forKey: .notes)
        brand = try container.decode(String.self, forKey: .brand)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        id = try container.decode(UUID.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
    }
    
    
    @Attribute(.unique) var id: UUID
    
    var userId: String
    var name: String
    var category: ClothingCategory
    var mainColor: ColorFamily
    var accentColor: ColorFamily
    var fit: Fit
    var notes: String
    var brand: String
    var isFavorite: Bool = false

    init(
        id: UUID = UUID(),
        userId: String,
        name: String,
        category: ClothingCategory,
        mainColor: ColorFamily,
        accentColor: ColorFamily = ColorFamily.none,
        fit: Fit,
        notes: String = "", brand: String,
        isFavorite: Bool
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.category = category
        self.mainColor = mainColor
        self.accentColor = accentColor
        self.fit = fit
        self.notes = notes
        self.isFavorite = isFavorite
        self.brand = brand
    }
    
    //Learned how to make classes confirm to encodable and decodable from
    //https://www.hackingwithswift.com/forums/swiftui/can-someone-explain-my-mistake-here/24252
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(mainColor, forKey: .mainColor)
        try container.encode(accentColor, forKey: .accentColor)
        try container.encode(fit, forKey: .fit)
        try container.encode(notes, forKey: .notes)
        try container.encode(brand, forKey: .brand)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
    }
    
    //Learned how to make a copy for class objects and code snippet below from
    //https://www.hackingwithswift.com/example-code/system/how-to-copy-objects-in-swift-using-copy
    func copy(with zone: NSZone? = nil) -> Any {
        var copy = ClothingItem(userId: userId, name: name, category: category, mainColor: mainColor, accentColor: accentColor, fit: fit, brand: brand, isFavorite: isFavorite)
            return copy
        }
    
    
    
}

