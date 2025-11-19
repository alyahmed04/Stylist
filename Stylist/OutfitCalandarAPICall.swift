//
//
//  Sources used for this file down below:
//  https://www.hackingwithswift.com/read/7/3/sending-and-receiving-data-with-urlsession
//  https://developer.apple.com/documentation/foundation/jsonencoder
//  
import Foundation

final class OutfitCalendarService {
    
    // Anthony's API Key
    private let rapidAPIKey = "9318d11039msh06b63962bebc392p16f3a1jsncca2e37d2774"
    
    // From RapidAPI docs / snippet on website: https://rapidapi.com/ChainLoop/api/outfit-calendar/playground/apiendpoint_e4cdb8b1-4bb7-4970-a99c-ace1d6e6cc63
    private let rapidAPIHost = "outfit-calendar.p.rapidapi.com"
    
    // We use the POST /user_input endpoint.
    private let baseURLString = "https://outfit-calendar.p.rapidapi.com/user_input"
    
    /// Main function your views will call.
    ///
    /// - Parameters:
    ///   - wardrobe: Clothing descriptions, e.g. ["black hoodie", "light blue jeans", "grey sneakers"].
    ///   - event: Occasion / style, e.g. "casual", "formal", "business".
    ///   - location: Optional city/region string (used by the API if we want weather-based outfits).
    ///   - completion: Returns OutfitCalendarResponse or Error.
    func getUserInputOutfit(
        wardrobe: [String],
        event: String,
        location: String?,
        completion: @escaping (Result<OutfitCalendarResponse, Error>) -> Void
    ) {
        guard let url = URL(string: baseURLString) else {
            return
        }
        
        //  Set them to nil so they are ignored
        let body = OutfitCalendarRequest(
            user_id: userId,
            wardrobe: wardrobe,
            location: location,           // e.g. "Blacksburg"
            event: event,                 // From your `occasion` in OutfitRecommendation
            date_time: nil,               // Not used in app
            repeat_after_days: nil        // Not used in app
        )
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Headers from RapidAPI snippet on website.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(rapidAPIKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue(rapidAPIHost, forHTTPHeaderField: "x-rapidapi-host")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Network error.
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let err = NSError(
                    domain: "OutfitCalendarService",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "No data returned from API"]
                )
                completion(.failure(err))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(OutfitCalendarResponse.self, from: data)
                completion(.success(apiResponse))
            } catch {
                
                #if DEBUG
                print("Decoding error:", error)
                print("Raw JSON:", String(data: data, encoding: .utf8) ?? "nil")
                #endif
                completion(.failure(error))
            }
        }.resume()
    }
}
