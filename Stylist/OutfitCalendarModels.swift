import Foundation

/// Request body for the Outfit Calendar POST /user_input endpoint. 
/// 
/// https://rapidapi.com/ChainLoop/api/outfit-calendar/playground/apiendpoint_e4cdb8b1-4bb7-4970-a99c-ace1d6e6cc63
///
/// Example JSON:
/// {
///   "user_id": "user123",
///   "wardrobe": [
///     "black jeans",
///     "white t-shirt",
///     "blue sweater"
///   ],
///   "location": "New York",
///   "event": "casual",
///   "date_time": "2023-03-20 12:00:00",
///   "repeat_after_days": 1
/// }
struct OutfitCalendarRequest: Codable {
    let user_id: String?
    let wardrobe: [String]
    let location: String?
    let event: String
    let date_time: String?
    let repeat_after_days: Int?
}

/// A generic response model for the Outfit Calendar API.
///
/// the actual JSON returned in your Xcode console.
struct OutfitCalendarResponse: Codable {
    /// Sometimes APIs return a list of items under keys like "outfit" or "recommended_outfit".
    let outfit: [String]?
    let recommended_outfit: [String]?
    
    /// Optional explanation or status message.
    let reason: String?
    let message: String?
    
    /// Convenience accessor for "some list of items".
    var items: [String] {
        if let outfit = outfit { return outfit }
        if let recommended = recommended_outfit { return recommended }
        return []
    }
}
