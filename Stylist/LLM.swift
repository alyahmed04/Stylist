//
//  Handles calls to the LLM (ChatGPT) to generate outfit recommendations.
//
//  - JSONEncoder:
//    https://developer.apple.com/documentation/foundation/jsonencoder
//
//  - Codable / Encodable for JSON serialization:
//    https://developer.apple.com/documentation/swift/codable
//
//  - URLRequest for building HTTP requests:
//    https://developer.apple.com/documentation/foundation/urlrequest
//
//  - URLSession for sending network requests:
//    https://developer.apple.com/documentation/foundation/urlsession
//
//  - OpenAI Chat Completions API (used for LLM):
//    https://platform.openai.com/docs/api-reference/chat/create
//
//  - StackOverflow reference for converting Swift objects to JSON:
//    https://stackoverflow.com/questions/29599005/how-to-serialize-or-convert-swift-objects-to-json

import Foundation

enum LLMError: LocalizedError {
    case encodingError
    case noData
    case invalidResponse(String)
    
    var errorDescription: String? {
        switch self {
        case .encodingError:
            return "Could not encode closet data for the LLM request."
        case .noData:
            return "No data was returned from the LLM API."
        case .invalidResponse(let details):
            return "Unexpected response from LLM API: \(details)"
        }
    }
}

final class LLM {
    static let shared = LLM()
    private init() {}
    
    // Aly's API key will go here
    private let apiKey = "YOUR_OPENAI_API_KEY_HERE"
    
    // OpenAI Chat Completions endpoint
    private let endpoint = URL(string: "https://api.openai.com/v1/chat/completions")!
    
    private let modelName = "gpt-4.1-mini"
    
    
    /// Uses the user's closet and preferences to ask the LLM for an outfit recommendation.
    func generateOutfitRecommendation(
        closet: [ClothingItem],
        occasion: Occasion,
        fit: Fit,
        weather: String,
        notes: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        // Convert closet to JSON so it becomes a proper "JSON list"
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        
        guard let closetData = try? encoder.encode(closet),
              let closetJSONString = String(data: closetData, encoding: .utf8) else {
            completion(.failure(LLMError.encodingError))
            return
        }
        
        // Build the user prompt
        let trimmedWeather = weather.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedNotes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let prompt = """
        You are a personal fashion stylist.

        The user's closet is provided below as a JSON array:
        \(closetJSONString)

        STYLE REQUEST:
        - Occasion: \(occasion.rawValue)
        - Preferred fit: \(fit.rawValue)
        - Weather: \(trimmedWeather.isEmpty ? "not specified" : trimmedWeather)
        - Additional notes: \(trimmedNotes.isEmpty ? "None" : trimmedNotes)

        TASK:
        Using ONLY items from the closet JSON above, create 1–2 complete outfits.

        For each outfit, include:
        - A short outfit name
        - Which items to wear (use exact item names from the JSON)
        - Required components:
            - 1 top
            - 1 bottom
            - Footwear
            - Outerwear only if needed
            - Optional accessories
        - A short explanation (1–2 sentences)

        RESPONSE STYLE:
        Use plain text with bullet points. Do NOT use JSON.
        """
        
        // Build the HTTP body for Chat Completions
        let body: [String: Any] = [
            "model": modelName,
            "messages": [
                [
                    "role": "system",
                    "content": "You are a helpful fashion stylist that gives clear outfit suggestions."
                ],
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "temperature": 0.8
        ]
        
        // Serialize HTTP body
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion(.failure(LLMError.encodingError))
            return
        }
        
        // Configure URLRequest
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        // Perform the network call
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(LLMError.noData))
                    return
                }
                
                // Parse Chat Completions Response
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]],
                       let first = choices.first,
                       let message = first["message"] as? [String: Any],
                       let content = message["content"] as? String {
                        
                        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
                        completion(.success(trimmed))
                    } else {
                        let raw = String(data: data, encoding: .utf8) ?? "Unknown response"
                        completion(.failure(LLMError.invalidResponse(raw)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }

     // Asks the LLM for a short "style tip of the day"
    func generateDailyStyleTip(
        userName: String?,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let namePart = (userName?.isEmpty == false) ? userName! : "stylist user"

        let prompt = """
        You are a friendly personal stylist.

        TASK:
        Give a single, short "style tip of the day" for \(namePart).

        REQUIREMENTS:
        - 1–2 sentences max
        - Focus on practical everyday outfit advice
        - No numbered lists or bullet points
        - Do not ask questions or mention that you are an AI/ChatGPT
        """

        let body: [String: Any] = [
            "model": modelName,
            "messages": [
                [
                    "role": "system",
                    "content": "You are a helpful fashion stylist that gives short, practical style tips."
                ],
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "temperature": 0.9
        ]

        guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion(.failure(LLMError.encodingError))
            return
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(LLMError.noData))
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let choices = json["choices"] as? [[String: Any]],
                       let first = choices.first,
                       let message = first["message"] as? [String: Any],
                       let content = message["content"] as? String {

                        completion(.success(content.trimmingCharacters(in: .whitespacesAndNewlines)))
                    } else {
                        let raw = String(data: data, encoding: .utf8) ?? "Unknown response"
                        completion(.failure(LLMError.invalidResponse(raw)))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
