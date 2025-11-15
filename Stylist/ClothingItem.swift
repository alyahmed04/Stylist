import SwiftUI
import Foundation
import SwiftData



enum ClothingCategory: String, Codable, CaseIterable, Identifiable {
    case top, bottom, outerwear, footwear, accessory
    public var id: String { rawValue }
}

enum ColorFamily: String, Codable, CaseIterable, Identifiable {
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


@Model
final class ClothingItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: ClothingCategory
    var color: ColorFamily
    var fit: Fit
    var notes: String?
    var isFavorite: Bool

    init(
        id: UUID = UUID(),
        name: String,
        category: ClothingCategory,
        color: ColorFamily,
        fit: Fit,
        notes: String? = nil,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.color = color
        self.fit = fit
        self.notes = notes
        self.isFavorite = isFavorite
    }
}
