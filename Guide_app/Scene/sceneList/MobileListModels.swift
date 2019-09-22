//
//  GuideModels.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

enum SortingStatus {
  case priceLowToHigh
  case priceHighToLow
  case rating
}
enum StatusBar{
  case all
  case favorite
}
struct MobileList {
  /// This structure represents a use case
  struct GetMobile {
    /// Data struct sent to Interactor
    struct Request {
      var typeBar: StatusBar
      
    }
    /// Data struct sent to Presenter
    struct Response {
        let mobile:Phone
        var checkFavDeleteRes: Bool
      var typeBar: StatusBar
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let mobile:Phone
      var checkFavDelete: Bool
       var typeBar: StatusBar
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
 
    /// This structure represents a use case
    struct SortMobileList {
      /// Data struct sent to Interactor
      struct RequestMobile {
        var sortingType: SortingStatus
      }
      /// Data struct sent to Presenter
      struct ResponseMobile {
        let mobile:Phone
        
      }
      /// Data struct sent to ViewController
      struct ViewModelMobile {
        let mobile:Phone
      }
    }
  
}
