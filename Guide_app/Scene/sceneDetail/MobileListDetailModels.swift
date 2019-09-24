//
//  sceneDetailModels.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

struct MobileListDetail {
  /// This structure represents a use case
  struct GetPhoneDetail {
    /// Data struct sent to Interactor
    struct Request {
      let idMobile: Int
    }
    /// Data struct sent to Presenter
    struct Response {
     let phoneImage : ImagePhone
      
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let phoneImage : ImagePhone
      
    }
  }
}

