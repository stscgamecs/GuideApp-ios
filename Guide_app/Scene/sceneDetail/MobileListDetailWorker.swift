//
//  sceneDetailWorker.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListDetailStoreProtocol {
  func getImageMobile(sent number: Int,_ completion: @escaping (Result<ImagePhones,ApiError>) -> Void)
}

class MobileListDetailWorker {
  
  var store: MobileListDetailStoreProtocol
  
  init(store: MobileListDetailStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  func getMobile(sent number: Int,_ completion: @escaping (Result<ImagePhones,ApiError>) -> Void) {
    store.getImageMobile(sent: number){
      completion($0)
    }
  }
}
