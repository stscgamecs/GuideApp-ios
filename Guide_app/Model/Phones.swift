// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let phone = try? newJSONDecoder().decode(Phone.self, from: jsonData)

import Foundation

// MARK: - PhoneElement
struct Mobile: Codable {
    let thumbImageURL: String?
    let brand: String?
    let rating: Double?
    let name, phoneDescription: String?
    let id: Int?
    let price: Double?
  
    enum CodingKeys: String, CodingKey {
        case thumbImageURL, brand, rating, name
        case phoneDescription = "description"
        case id, price
    }
    
}

typealias Phones = [Mobile]
