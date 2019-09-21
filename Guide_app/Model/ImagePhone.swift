//
//  sceneDetailEntity.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation

struct ImagePhone: Codable {
  let mobileID, id: Int
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case mobileID = "mobile_id"
    case id, url
  }
}

typealias ImagePhone = [ImagePhone]
