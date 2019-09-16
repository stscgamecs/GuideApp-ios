////
////  ApiBeers.swift
////  MyProjectTestGit
////
////  Created by Z64me on 12/9/2562 BE.
////  Copyright © 2562 Z64me. All rights reserved.
////
//
//import Foundation
//enum APIError: Error {
//    case invalidJSON
//    case invalidData
//}
//class ApiBeers {
//    func getBeers<T: Codable>(urlString: String, completion: @escaping (Result<[T], APIError>) -> Void) {
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let _ = error {
//                completion(.failure(.invalidData))
//            } else if let data = data, let response = response as? HTTPURLResponse {
//                if response.statusCode == 200 {
//                    do {
//                        let values = try JSONDecoder().decode([T].self, from: data)
//                        print(values)
//                        completion(.success(values))
//                    } catch {
//                        completion(.failure(.invalidJSON))
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
//}
