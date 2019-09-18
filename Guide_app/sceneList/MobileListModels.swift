//
//  GuideModels.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

struct MobileList {
  /// This structure represents a use case
  struct Something {
    /// Data struct sent to Interactor
    struct Request {
        
    }
    /// Data struct sent to Presenter
    struct Response {
        let mobile:Phone
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let mobile:Phone
    }
  }
}
