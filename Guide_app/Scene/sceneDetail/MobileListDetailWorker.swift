//
//  sceneDetailWorker.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListDetailStoreProtocol {
  func getImageMobile(_ completion: @escaping (Result<ImagePhone,ApiError>) -> Void)
}

class MobileListDetailWorker {

  var store: MobileListDetailStoreProtocol

  init(store: MobileListDetailStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  func getMobile(_ completion: @escaping (Result<ImagePhone,ApiError>) -> Void) {
    store.getImageMobile{
      completion($0)
    }
  }

}
