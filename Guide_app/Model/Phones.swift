// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let phone = try? newJSONDecoder().decode(Phone.self, from: jsonData)

import Foundation

// MARK: - PhoneElement
struct Mobile: Codable {
    let thumbImageURL: String?
    let brand: String?
    var rating: Double?
   var name, phoneDescription: String?
    var id: Int?
    var price: Double?
  
    enum CodingKeys: String, CodingKey {
        case thumbImageURL, brand, rating, name
        case phoneDescription = "description"
        case id, price
    }
    
}

typealias Phones = [Mobile]
