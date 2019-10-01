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
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      var phoneImages : ImagePhones
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let phoneImages : ImagePhones
      let arrayStringImage: [String]
    }
  }
  
  struct GetPhone {
    /// Data struct sent to Interactor
    struct Request { }
    /// Data struct sent to Presenter
    struct Response {
      var phone : Mobile
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      var price : String
      var rating : String
      var Discription : String
    }
  }
}

