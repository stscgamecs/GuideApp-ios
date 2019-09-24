//
//  GuideStore.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ApiError: Error {
  case success
  case jsonError
  case networkError
}

class MobileListStore: MobileListStoreProtocol {
  
  func getPhone(_ completion: @escaping (Result<Phone, ApiError>) -> Void) {
    guard let url = URL(string: "https://scb-test-mobile.herokuapp.com/api/mobiles/") else {
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
      if let _ = error {
        print("error")
      } else if let data = data, let response = response as? HTTPURLResponse {
          DispatchQueue.main.async {
        if response.statusCode == 200 {
          
          do {
              let mobileList: Phone = try JSONDecoder().decode(Phone.self, from: data)
              completion(Result.success(mobileList))
          } catch(let error) {
            print("parse JSON failed")
            print(error)
            completion(Result.failure(ApiError.jsonError))
          }
        }
      }
      }
      
    }
    task.resume()
  }
  
 
  
  
}
