import SwiftUI
import Foundation

public enum ClothingCategory: String, Codable, CaseIterable, Identifiable {
    case top, bottom, outerwear, footwear, accessory
    public var id: String { rawValue }
}

public enum ColorFamily: String, Codable, CaseIterable, Identifiable {
    case black, white, blue, red, green, yellow, brown, gray, purple, orange, pink
    public var id: String { rawValue }
}

public enum Fit: String, Codable, CaseIterable, Identifiable {
    case slim, regular, relaxed, oversized
    public var id: String { rawValue }
}

public enum Occasion: String, Codable, CaseIterable, Identifiable {
    case casual, smartCasual, business, formal, active
    public var id: String { rawValue }
}

public enum BudgetLevel: String, Codable, CaseIterable, Identifiable {
    case low, medium, high
    public var id: String { rawValue }
}
