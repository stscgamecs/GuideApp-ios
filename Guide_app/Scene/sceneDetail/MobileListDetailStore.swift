//
//  sceneDetailStore.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
/*
 
 The sceneDetailStore class implements the sceneDetailStoreProtocol.
 
 The source for the data could be a database, cache, or a web service.
 
 You may remove these comments from the file.
 
 */

class MobileListDetailStore: MobileListDetailStoreProtocol {
  
  
  
  func getImageMobile(sent mobile_id:Int, _ completion: @escaping (Result<ImagePhones, ApiError>) -> Void) {
    
    
    
    
    guard let todoEndpoint = URL(string: "https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobile_id)/images/") else {
      return
    }

    AF.request(todoEndpoint)
      .responseJSON { response in

        switch response.result{
        case .success(let dataImage):

          let array = JSON(dataImage)
          var images: ImagePhones = []

          for json in array.arrayValue {
            let decoder = JSONDecoder()
            if let image = try? decoder.decode(ImageMobile.self, from: json.rawData()) {
              
//               image.url = "https://\(image.url)"
                images.append(image)
//              if image.url ==  "https://\(image.url)"{
//                let urlImage = image
//                images.append(urlImage)
//              }
              
              
            }
          }
          completion(.success(images))

        case .failure(let error):
          print(error)

          completion(Result.failure(ApiError.jsonError))
        }
    }
    
    
    
  }
  
  
  
  
  
  
  
  
}
