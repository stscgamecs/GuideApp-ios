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

enum SegmentStatus {
  case all
  case favorite
}

struct MobileList {
  
  /// This structure represents a use case
  struct GetMobile {
    
    /// Data struct sent to Interactor
    struct Request {
      var segmentStatus: SegmentStatus
    }
    
    /// Data struct sent to Presenter
    struct Response {
      let mobile:Phones
    }
    
    /// Data struct sent to ViewController
    struct ViewModel {
      let mobile:Phones
    }
  }
  
   /// This structure represents a use case
  struct AddFavoritMobile {
    
     /// Data struct sent to Interactor
    struct Request {
      let indexCell: Int
    }
     /// Data struct sent to Presenter
    struct Response {
      let checkFavorit: [Int:Bool]
    }
     /// Data struct sent to ViewController
    struct ViewModel {
      let checkFavorit: [Int: Bool]
    }
  }
  
  /// This structure represents a use case
  struct SortMobileList {
    
    /// Data struct sent to Interactor
    struct RequestMobile {
      var sortingStatus: SortingStatus
    }
    
    /// Data struct sent to Presenter
    struct ResponseMobile {
      let mobile:Phones
    }
    
    /// Data struct sent to ViewController
    struct ViewModelMobile {
      let mobile:Phones
    }
  }
  
}
