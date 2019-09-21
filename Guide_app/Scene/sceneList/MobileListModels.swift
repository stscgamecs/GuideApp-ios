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
  struct GetMobile {
    /// Data struct sent to Interactor
    struct Request {
      var checkFav: Bool
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


  struct AddFavoritMobile {
    
    struct Request {
      let indexCell: Int
    }
    
    struct Response {
      
      let checkFavorit: [Int:Bool]
    }
  
    struct ViewModel {
      let checkFavorit: [Int: Bool]
    }
  }
  
  
}
